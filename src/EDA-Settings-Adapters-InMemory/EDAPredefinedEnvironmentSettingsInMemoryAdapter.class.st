Class {
	#name : #EDAPredefinedEnvironmentSettingsInMemoryAdapter,
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
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #ambiguous }
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> description [
	^ 'Predefined list'
]

{ #category : #testing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> priority [
	^ 50
]

{ #category : #testing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> availableEnvironments [
	^ OrderedCollection with: 'dev' with: 'test' with: 'PRO'
]

{ #category : #accessing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> currentEnvironment [
	^ currentEnvironment ifNil: [ self availableEnvironments first ]
]

{ #category : #accessing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> currentEnvironment: anEnvironment [
	currentEnvironment := anEnvironment
]

{ #category : #accessing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]

{ #category : #accessing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> resolveEnvironmentSettingsPort [
	^ self
]

{ #category : #testing }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> supportsMultiple [
	^ true
]
