Class {
	#name : #EDAMongoProjectionSettingsInMemoryAdapter,
	#superclass : #EDAMongoSettingsInMemoryAdapter,
	#traits : 'EDAProjectionSettingsPort',
	#classTraits : 'EDAProjectionSettingsPort classTrait',
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAMongoProjectionSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #testing }
EDAMongoProjectionSettingsInMemoryAdapter >> priority [
	^ 0
]
