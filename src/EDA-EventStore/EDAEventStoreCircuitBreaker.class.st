Class {
	#name : #EDAEventStoreCircuitBreaker,
	#superclass : #EDAApplicationCircuitBreaker,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#category : #'EDA-EventStore'
}

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> checkResourceBlockForApplication: anEDAApplication [
	^ anEDAApplication eventStoreCheckBlock
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> circuitBreakerProcessName [
	^ 'Event Store Circuit Breaker Loop'
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> closeCircuitBlockForApplication: anEDAApplication [
	^ anEDAApplication startCommandConsumerBlock
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> maxConsecutiveResourceCheckFailuresForApplication: anEDAApplication [
	^ anEDAApplication eventStoreMaxConsecutiveCheckFailures
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> minConsecutiveResourceCheckSuccessesForApplication: anEDAApplication [
	^ anEDAApplication eventStoreMinConsecutiveCheckSuccesses
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> monitoredResourceForApplication: anEDAApplication [
	^ anEDAApplication eventStore
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> openCircuitBlockForApplication: anEDAApplication [
	^ anEDAApplication stopCommandConsumerBlock
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> resourceCheckingPeriodForApplication: anEDAApplication [
	^ anEDAApplication eventStoreCheckingPeriod
]
