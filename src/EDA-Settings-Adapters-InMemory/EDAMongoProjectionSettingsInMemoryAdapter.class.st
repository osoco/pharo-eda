Class {
	#name : #EDAMongoProjectionSettingsInMemoryAdapter,
	#superclass : #EDAMongoSettingsInMemoryAdapter,
	#traits : 'EDAProjectionSettingsPort',
	#classTraits : 'EDAProjectionSettingsPort classTrait',
	#instVars : [
		'concurrentSynchronization',
		'headlessMode',
		'strategy',
		'projectionSynchronizationEnabled'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAMongoProjectionSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> concurrentSynchronization [
	^ concurrentSynchronization
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> concurrentSynchronization: aBoolean [
	concurrentSynchronization := aBoolean
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> headlessMode [
	^ headlessMode
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> headlessMode: aBoolean [
	headlessMode := aBoolean
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> priority [
	^ 0
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> projectionSynchronizationEnabled [
	^ projectionSynchronizationEnabled
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> projectionSynchronizationEnabled: aBoolean [
	projectionSynchronizationEnabled := aBoolean
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAMongoProjectionSettingsInMemoryAdapter >> strategy: aStrategy [
	strategy := aStrategy
]
