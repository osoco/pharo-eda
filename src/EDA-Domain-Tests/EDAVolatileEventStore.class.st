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
	^ filteredEvents deepCopy
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
