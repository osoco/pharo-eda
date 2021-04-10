Class {
	#name : #EDAVolatileEventStore,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #filtering }
EDAVolatileEventStore class >> filterEvents: anEventCollection byCriteria: aCriteriaDictionary [
	^ anEventCollection
		select: [ :event | 
			| commonAttrs |
			commonAttrs := event class allInstVarNames
				intersection: (aCriteriaDictionary keys collect: [ :k | k asSymbol ]).
			commonAttrs size = aCriteriaDictionary size
				ifTrue: [ | attrPassCriteria |
					attrPassCriteria := commonAttrs
						select:
							[ :attr | (event perform: attr) = (aCriteriaDictionary at: attr) "EDATestEventStub new attribute: (event perform: attr) named: attr matches: (aCriteriaDictionary at: attr)" ].
					attrPassCriteria size = commonAttrs size ]
				ifFalse: [ false ] ]
]

{ #category : #helpers }
EDAVolatileEventStore >> canBeSavedInTheEventStore: anEvent [
	^ anEvent isEventSourcingEvent
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
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofAggregate: aClass whereCriteria: aDict [
	| eventsPerTenant aggregateEvents filteredEvents |
	eventsPerTenant := self events
		at: aTenant
		ifAbsent: [ Dictionary new ].
	aggregateEvents := eventsPerTenant
		at: aClass
		ifAbsent: [ OrderedCollection new ].
	filteredEvents := self class filterEvents: aggregateEvents byCriteria:  aDict.
	^ filteredEvents
]

{ #category : #filtering }
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber [
	^ self
		findEventsOfTenant: aTenant
		ofAggregate: anAggregateRootClass
		whereCriteria: (Dictionary
		with: 'id' -> aNumber)
]

{ #category : #save }
EDAVolatileEventStore >> saveEvents: aCollection [
	aCollection
		do: [ :e | 
			| evts evtCollection |
			(self canBeSavedInTheEventStore: e) ifTrue: [ 
			evts := self events at: e tenant ifAbsent: [ Dictionary new ].
			evts ifEmpty: [ self events at: e tenant put: evts ].
			evtCollection := evts
				at: e aggregateRootClass
				ifAbsent: [ OrderedCollection new ].
			evtCollection
				ifEmpty: [ evts at: e aggregateRootClass put: evtCollection ].
			evtCollection add: e ] ]
]
