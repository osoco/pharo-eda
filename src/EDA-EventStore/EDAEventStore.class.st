Class {
	#name : #EDAEventStore,
	#superclass : #Object,
	#traits : 'EDACTPrintOnHelper',
	#classTraits : 'EDACTPrintOnHelper classTrait',
	#instVars : [
		'repository'
	],
	#category : #'EDA-EventStore'
}

{ #category : #persistence }
EDAEventStore >> doInitialize [
	self repository: self initBackendRepository
]

{ #category : #persistence }
EDAEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass [
	^ self
		findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass
		whereCriteria: Dictionary new
]

{ #category : #persistence }
EDAEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary [
	self subclassResponsibility
]

{ #category : #persistence }
EDAEventStore >> findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber [
	self subclassResponsibility
]

{ #category : #persistence }
EDAEventStore >> findEventsOfTenant: aTenant ofType: anEventClass [
	^ self
		findEventsOfTenant: aTenant ofAggregate: anEventClass aggregateRootClass
		whereCriteria: {('#instanceOf' -> anEventClass greaseString)} asDictionary
]

{ #category : #persistence }
EDAEventStore >> findEventsOfTenant: aTenant ofType: anEventClass whereCriteria: aCriteria [
	| criteria |
	criteria := Dictionary newFrom: aCriteria.
	criteria at: '#instanceOf' put: anEventClass greaseString.
	^ self
		findEventsOfTenant: aTenant
		ofAggregate: anEventClass aggregateRootClass
		whereCriteria: criteria
]

{ #category : #persistence }
EDAEventStore >> flush [
	self repository flush

	
]

{ #category : #persistence }
EDAEventStore >> initBackendRepository [
	self subclassResponsibility
]

{ #category : #initialization }
EDAEventStore >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #initialization }
EDAEventStore >> repository [
	^ repository
]

{ #category : #accessing }
EDAEventStore >> repository: aRepository [
	repository := aRepository
]

{ #category : #persistence }
EDAEventStore >> saveEvents: anEventCollection [
	self subclassResponsibility
]
