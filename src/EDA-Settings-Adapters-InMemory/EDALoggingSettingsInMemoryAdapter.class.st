Class {
	#name : #EDALoggingSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATLoggingSettingsPort + EDATInMemoryAdapter',
	#classTraits : 'EDATLoggingSettingsPort classTrait + EDATInMemoryAdapter classTrait',
	#instVars : [
		'loggingLevel',
		'edaApplication'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDALoggingSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #accessing }
EDALoggingSettingsInMemoryAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDALoggingSettingsInMemoryAdapter >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]

{ #category : #accessing }
EDALoggingSettingsInMemoryAdapter >> loggingLevel [
	^ loggingLevel
]

{ #category : #accessing }
EDALoggingSettingsInMemoryAdapter >> loggingLevel: aString [
	loggingLevel := aString
]
