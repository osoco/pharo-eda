Class {
	#name : #EDAPredefinedEnvironmentSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATEnvironmentSettingsPort + EDAPrintOnHelper + EDATInMemoryAdapter + EDATCollectionHelper',
	#classTraits : 'EDATEnvironmentSettingsPort classTrait + EDAPrintOnHelper classTrait + EDATInMemoryAdapter classTrait + EDATCollectionHelper classTrait',
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

{ #category : #meta }
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> availableEnvironments [
	^ OrderedCollection with: 'dev' with: 'test' with: 'PRO'
]

{ #category : #meta }
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> description [
	^ 'Predefined list (', (self concatenateCollection: self availableEnvironments with: ', ') , ')'
]

{ #category : #meta }
EDAPredefinedEnvironmentSettingsInMemoryAdapter class >> priority [
	^ 60
]

{ #category : #meta }
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> availableEnvironments [
	^ self class availableEnvironments 
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
EDAPredefinedEnvironmentSettingsInMemoryAdapter >> supportsMultiple: aSymbol [
	^ true
]
