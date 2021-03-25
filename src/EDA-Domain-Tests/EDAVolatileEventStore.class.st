Class {
	#name : #EDAVolatileEventStore,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #accessing }
EDAVolatileEventStore >> events [
	events ifNil: [ self events: Dictionary new ].
	^ events
]

{ #category : #accessing }
EDAVolatileEventStore >> events: anObject [
	events := anObject
]

{ #category : #'as yet unclassified' }
EDAVolatileEventStore >> findEventsOfTenant: aTenant ofAggregate: aClass whereCriteria: aDict [
	| eventsPerAggregate aggregateEvents |
	eventsPerAggregate := self events
		at: aTenant
		ifAbsent: [ Dictionary new ].
	aggregateEvents := eventsPerAggregate
		at: aClass
		ifAbsent: [ OrderedCollection new ].
	^ aggregateEvents
]

{ #category : #save }
EDAVolatileEventStore >> saveEvents: aCollection [
	aCollection
		do: [ :e | 
			| evts evtCollection |
			evts := self events at: e tenant ifAbsent: [ Dictionary new ].
			evts ifEmpty: [ self events at: e tenant put: evts ].
			evtCollection := evts
				at: e aggregateRootClass
				ifAbsent: [ OrderedCollection new ].
			evtCollection
				ifEmpty: [ evts at: e aggregateRootClass put: evtCollection ].
			evtCollection add: e ]
]
