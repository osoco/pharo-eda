Class {
	#name : #EDAMemoryEventStore,
	#superclass : #EDAEventStore,
	#category : 'EDA-Voyage-EventStore'
}

{ #category : #persistence }
EDAMemoryEventStore >> allEvents [
	^ EDAEventSourcingEvent selectAll
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
EDAMemoryEventStore >> saveEvents: anEventCollection onAggregate: aggregateRoot [
	anEventCollection do: [ :event | event save ]
]