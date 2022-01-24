Class {
	#name : #EDAVolatileEventStore,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #filtering }
EDAVolatileEventStore class >> event: anEvent satisfyCriteria: aCriteriaDictionary [
	^ aCriteriaDictionary associations allSatisfy: [ :assoc |
		((self queryBlockFromKey: assoc key) value: anEvent) = assoc value ]
]

{ #category : #filtering }
EDAVolatileEventStore class >> filterEvents: anEventCollection byCriteria: aCriteriaDictionary [
	| selectors |
	selectors := self selectorsFromCriteriaDictionary: aCriteriaDictionary.
	^ anEventCollection
		select: [ :event | 
			(event class allInstVarNames includesAll: selectors)
				and: [ 
					self event: event satisfyCriteria: aCriteriaDictionary ] ]
]

{ #category : #filtering }
EDAVolatileEventStore class >> queryBlockFromKey: aKey [
	| selectors |
	selectors := (aKey asString splitOn: '.') collect: [ :string | string asSymbol ].
	^ [ :event | selectors inject: event into: [ :receiver :selector | selector value: receiver ] ] 
	
]

{ #category : #filtering }
EDAVolatileEventStore class >> selectorsFromCriteriaDictionary: aCriteriaDictionary [ 
	^ aCriteriaDictionary keys collect: [ :k | (k splitOn: '.') first asSymbol ]
]

{ #category : #accessing }
EDAVolatileEventStore >> events [
	events ifNil: [ self events: Dictionary new ].
	^ events
]

{ #category : #accessing }
EDAVolatileEventStore >> events: anObject [
	events := anObject
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfAggregate: aClass whereCriteria: aDict [
	| aggregateEvents filteredEvents |
	aggregateEvents := self events
		at: aClass
		ifAbsent: [ OrderedCollection new ].
	filteredEvents := self class filterEvents: aggregateEvents byCriteria:  aDict.
	^ filteredEvents deepCopy
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfAggregate: anAggregateRootClass whereId: aNumber [
	^ self
		findEventsOfAggregate: anAggregateRootClass
		whereCriteria: (Dictionary
		with: 'id' -> aNumber)
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofAggregate: aClass whereCriteria: aCriteriaDictionary [
	| eventsCriteria |
	eventsCriteria := Dictionary newFrom: aCriteriaDictionary.
	eventsCriteria at: 'tenant' put: aTenant.
	^ self findEventsOfAggregate: aClass whereCriteria: eventsCriteria
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber [
	^ self
		findEventsOfTenant: aTenant
		ofAggregate: anAggregateRootClass
		whereCriteria: (Dictionary
		with: 'id' -> aNumber)
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofType: anEventClass whereCriteria: aCriteria [
	^ (self
		findEventsOfTenant: aTenant
		ofAggregate: anEventClass aggregateRootClass
		whereCriteria: aCriteria) select: [ :evt | evt className = anEventClass greaseString ]
]

{ #category : #save }
EDAVolatileEventStore >> saveEvents: aCollection [
	aCollection
		do: [ :e | 
			| evtCollection |
			evtCollection := self events
				at: e aggregateRootClass
				ifAbsentPut: [ OrderedCollection new ].
			evtCollection add: e ]
]
