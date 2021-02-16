Class {
	#name : #EDAEnvironmentSettingsEnvVarAdapter,
	#superclass : #Object,
	#traits : 'EDATEnvironmentSettingsPort + EDATEnvVarAdapter',
	#classTraits : 'EDATEnvironmentSettingsPort classTrait + EDATEnvVarAdapter classTrait',
	#instVars : [
		'edaApplication'
	],
	#category : #'EDA-Settings-Adapters-EnvVars'
}

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter class >> description [
	^ self environmentVariableName , ' environment variable'
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter class >> environmentVariableName [
	^ DUEnvironment environmentVariableName 
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter class >> priority [
	^ 50
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> availableEnvironments [ 
	^ OrderedCollection with: (self currentEnvironment)
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> currentEnvironment [
	^ self getValueFor: self environmentVariableName orElse: '(' , self environmentVariableName , ' not set)'
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> description [
	^ self environmentVariableName , ' environment variable'
]

{ #category : #accessing }
EDAEnvironmentSettingsEnvVarAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAEnvironmentSettingsEnvVarAdapter >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> environmentVariableName [
	^ self class environmentVariableName
]
