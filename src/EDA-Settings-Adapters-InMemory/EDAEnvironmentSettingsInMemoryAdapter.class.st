Class {
	#name : #EDAEnvironmentSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDAEnvironmentSettingsPort + EDAPrintOnHelper + EDAInMemoryAdapter',
	#classTraits : 'EDAEnvironmentSettingsPort classTrait + EDAPrintOnHelper classTrait + EDAInMemoryAdapter classTrait',
	#instVars : [
		'currentEnvironment'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAEnvironmentSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #testing }
EDAEnvironmentSettingsInMemoryAdapter class >> priority [
	^ 99
]

{ #category : #accessing }
EDAEnvironmentSettingsInMemoryAdapter >> currentEnvironment [
	^ currentEnvironment
]

{ #category : #accessing }
EDAEnvironmentSettingsInMemoryAdapter >> currentEnvironment: anObject [
	currentEnvironment := anObject
]
