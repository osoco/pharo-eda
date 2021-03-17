Class {
	#name : #EDAAggregateRepository,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'eventStore'
	],
	#classInstVars : [
		'eventStore',
		'uniqueInstance'
	],
	#category : #'EDA-Domain-Repository'
}

{ #category : #accessing }
EDAAggregateRepository class >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAAggregateRepository class >> eventStore: anEventStore [
	eventStore := anEventStore
]

{ #category : #setup }
EDAAggregateRepository class >> setupEventStore: anEventStore [
	anEventStore
		ifNotNil: [ :es | 
			self eventStore: es.
			self uniqueInstance: nil ]
]

{ #category : #setup }
EDAAggregateRepository class >> uniqueInstance [
	| result |
	result := uniqueInstance.
	result
		ifNil: [
            result := self new.
			self uniqueInstance: result.
	        result eventStore ifNil: [ result eventStore: self eventStore ] ].
	^ result

]

{ #category : #setup }
EDAAggregateRepository class >> uniqueInstance: theInstance [
	uniqueInstance := theInstance
]

{ #category : #protected }
EDAAggregateRepository >> aggregateClass [
	self subclassResponsibility 
]

{ #category : #protected }
EDAAggregateRepository >> aggregateIdFor: anEvent [
	^ anEvent id
]

{ #category : #accessing }
EDAAggregateRepository >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAAggregateRepository >> eventStore: aStore [
	eventStore := aStore
]

{ #category : #api }
EDAAggregateRepository >> findAllEventsOfTenant: aTenant [
	^ self findAllEventsOfTenant: aTenant matching: Dictionary new
]

{ #category : #api }
EDAAggregateRepository >> findAllEventsOfTenant: aTenant matching: aDict [
	| result aggregateClass |
	aggregateClass := self aggregateClass.
	result := self eventStore
		findEventsOfTenant: aTenant ofAggregate: aggregateClass
		whereCriteria: aDict.
	result ifNil: [ result := OrderedCollection new ].
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findAllIgnoringExceptionsOfTenant: aTenant [
	^ self
		findAllOfTenant: aTenant withApplyEventsBlock:
			[ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]
]

{ #category : #api }
EDAAggregateRepository >> findAllOfTenant: aTenant [
	^ self
		findAllOfTenant: aTenant withApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]
]

{ #category : #api }
EDAAggregateRepository >> findAllOfTenant: aTenant withApplyEventsBlock: aBlock [
	| result events aux aggregateClass |
	result := OrderedCollection new.
	aggregateClass := self aggregateClass.
	events := self findAllEventsOfTenant: aTenant.
	aux := self groupEventsByAggregateRootId: events.
	aux
		keysAndValuesDo: [ :key :eventList |
			| aggregate |
			aggregate := aggregateClass new.
			aBlock value: aggregate value: eventList.
			result add: aggregate ].
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findAllOfTenant: aTenant withCriteria: aDictionary [
	| result criteria events eventsGroupedById |
	result := OrderedCollection new.
	criteria := Dictionary newFrom: aDictionary.
	criteria at: '#instanceOf' put: self aggregateClass asString.
	events := self findAllEventsOfTenant: aTenant matching: criteria.
	eventsGroupedById := self groupEventsByAggregateRootId: events.
	eventsGroupedById
		keysAndValuesDo: [ :k :v | 
			| aggregate |
			aggregate := self aggregateClass new.
			aggregate applyEvents: v.
			result add: aggregate ].
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findByIdOfTenant: aTenant ignoringExceptions: anId [
	^ self
		findOfTenant: aTenant byId: anId
		withApplyEventsBlock:
			[ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]
]

{ #category : #api }
EDAAggregateRepository >> findEventOfTenant: aTenant byId: anId andType: aType [
	^ self findEventOfTenant: aTenant byId: anId type: aType andCommandId: nil
]

{ #category : #api }
EDAAggregateRepository >> findEventOfTenant: aTenant byId: anId type: aType andCommandId: aCommandId [
	| criteria result |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	criteria at: '#instanceOf' put: aType greaseString.
	aCommandId ifNotNil: [ :cId | criteria at: 'commandId' put: cId ].
	result := self findAllEventsOfTenant: aTenant matching: criteria.
	^ result
		ifEmpty: [ nil ]
		ifNotEmpty: [ :r |
			r size > 1
				ifTrue: [ self
						logErrorMessage:
							'More than one event of type ' , aType greaseString , ', id '
								, anId greaseString , ' and command id: '
								, aCommandId greaseString , '.' ].
			r first ]
]

{ #category : #api }
EDAAggregateRepository >> findEventsById: anId [
	| result criteria |
	anId ifNil: [ ^ #() ] 
	ifNotNil: [   
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	result := self eventStore
		findEventsOfAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result
	]
]

{ #category : #api }
EDAAggregateRepository >> findEventsOf: aCollection matchingClass: aClass [
	| result |
	result :=
		aCollection
			ifNil: [ OrderedCollection new ]
			ifNotNil: [ :col |
				 col
					ifEmpty: [ col ]
					ifNotEmpty: [ :c |
						c select: [ :e | (e class = aClass) or: [ e class isKindOf: aClass ] ]
					]
			].
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findEventsOfTenant: aTenant byId: anId [
	| result criteria |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	result := self eventStore
		findEventsOfTenant: aTenant ofAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findEventsOfTenant: aTenant byScopeKey: anObject [
	| result criteria |
	criteria := Dictionary new.
	anObject ifNotNil: [ :aKey |
	criteria at: 'scopeKey' put: aKey ].
	result := self eventStore
		findEventsOfTenant: aTenant
		ofAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findEventsOfTenant: aTenant ofType: aType [
	^ self
		findAllEventsOfTenant: aTenant matching: {('#instanceOf' -> aType greaseString)} asDictionary
]

{ #category : #api }
EDAAggregateRepository >> findFirstEventOf: aCollection matchingClass: aClass [
	| result events |
	events := self findEventsOf: aCollection matchingClass: aClass.
	result := events ifEmpty: [ nil ] ifNotEmpty: [ :c | c first ].
	^ result
]

{ #category : #api }
EDAAggregateRepository >> findOfTenant: aTenant byId: anId [
	^ self
		findOfTenant: aTenant byId: anId
		withApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]
]

{ #category : #api }
EDAAggregateRepository >> findOfTenant: aTenant byId: anId withApplyEventsBlock: aBlock [
	| result events |
	events := self findEventsOfTenant: aTenant byId: anId.
	events
		ifEmpty: [ self
				logWarningMessage:
					'No ' , self aggregateClass greaseString , ' found with '
						, (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]) , '.'.
			result := nil ]
		ifNotEmpty: [ :evts |
			result := self aggregateClass new.
			aBlock value: result value: evts.
			result isDeleted
				ifTrue: [ result := nil ] ].
	^ result
]

{ #category : #protected }
EDAAggregateRepository >> groupEventsByAggregateRootId: events [
	| result |
	result := Dictionary new.
	events
		do: [ :evt | 
			| list id |
			id := self aggregateIdFor: evt.
			list := result at: id ifAbsent: [ OrderedCollection new ].
			list add: evt.
			result at: id put: list ].
	^ result
]
