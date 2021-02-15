Class {
	#name : #EDAEnvironmentSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATEnvironmentSettingsPort + EDAPrintOnHelper + EDATInMemoryAdapter',
	#classTraits : 'EDATEnvironmentSettingsPort classTrait + EDAPrintOnHelper classTrait + EDATInMemoryAdapter classTrait',
	#instVars : [
		'currentEnvironment',
		'edaApplication'
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
	^ currentEnvironment ifNil: [ '' ]
]

{ #category : #accessing }
EDAEnvironmentSettingsInMemoryAdapter >> currentEnvironment: anObject [
	currentEnvironment := anObject
]

{ #category : #accessing }
EDAEnvironmentSettingsInMemoryAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAEnvironmentSettingsInMemoryAdapter >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]

{ #category : #logic }
EDAEnvironmentSettingsInMemoryAdapter >> resolveEnvironmentSettingsPort [
	^ self
]

{ #category : #testing }
EDAEnvironmentSettingsInMemoryAdapter >> supportsMultiple [
	^ false
]
