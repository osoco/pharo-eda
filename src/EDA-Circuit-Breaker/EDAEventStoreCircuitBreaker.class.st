Class {
	#name : #EDAEventStoreCircuitBreaker,
	#superclass : #EDAApplicationCircuitBreaker,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#category : #'EDA-Circuit-Breaker'
}

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> checkResourceBlockForApplication: anEDAApplication [
	^ anEDAApplication eventStoreCheckBlock
]

{ #category : #constants }
EDAEventStoreCircuitBreaker class >> circuitBreakerClosedExceptionClass [
	^ EDAEventStoreCircuitBreakerClosed
]

{ #category : #'instance variables' }
EDAEventStoreCircuitBreaker class >> circuitBreakerName [
	^ 'Event Store Circuit Breaker'
]

{ #category : #constants }
EDAEventStoreCircuitBreaker class >> circuitBreakerOpenedExceptionClass [
	^ EDAEventStoreCircuitBreakerOpened
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
