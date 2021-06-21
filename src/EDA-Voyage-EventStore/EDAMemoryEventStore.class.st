Class {
	#name : #EDAMemoryEventStore,
	#superclass : #EDAEventStore,
	#category : #'EDA-Voyage-EventStore'
}

{ #category : #persistence }
EDAMemoryEventStore >> allEvents [
	^ EDAEventSourcingEvent selectAll
]

{ #category : #accessing }
EDAMemoryEventStore >> findEventsOfAggregate: anAggregate whereCriteria: aDictionary [
	^ self shouldBeImplemented
]

{ #category : #persistence }
EDAMemoryEventStore >> findEventsOfAggregate: anAggregateRootClass whereId: aNumber [
	^ EDAEventSourcingEvent
		selectMany: [ :event |
			event aggregateRootClass = anAggregateRootClass asString
				and: [ event id = aNumber ] ]
]

{ #category : #accessing }
EDAMemoryEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregate whereCriteria: aDictionary [
	^ self shouldBeImplemented
]

{ #category : #persistence }
EDAMemoryEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber [
	^ EDAEventSourcingEvent
		selectMany: [ :event |
			event aggregateRootClass = anAggregateRootClass asString
				and: [ event tenant = aTenant and: [ event id = aNumber ] ] ]
]

{ #category : #persistence }
EDAMemoryEventStore >> initBackendRepository [
	| result |
	result := VOMemoryRepository new.
	result enableSingleton.
	^ result
]

{ #category : #persistence }
EDAMemoryEventStore >> saveEvents: anEventCollection [
	anEventCollection do: [ :event | event save ]
]
