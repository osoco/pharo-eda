Class {
	#name : #EDALoggingSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDALoggingSettingsPort + EDAInMemoryAdapter',
	#classTraits : 'EDALoggingSettingsPort classTrait + EDAInMemoryAdapter classTrait',
	#instVars : [
		'loggingLevel'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDALoggingSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #testing }
EDALoggingSettingsInMemoryAdapter >> loggingLevel [
	^ loggingLevel
]

{ #category : #testing }
EDALoggingSettingsInMemoryAdapter >> loggingLevel: aString [
	loggingLevel := aString
]
