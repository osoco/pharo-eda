Class {
	#name : #EDAEnvironmentSettingsEnvVarAdapter,
	#superclass : #Object,
	#traits : 'EDAEnvironmentSettingsPort + EDAEnvVarAdapter',
	#classTraits : 'EDAEnvironmentSettingsPort classTrait + EDAEnvVarAdapter classTrait',
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
	^ self getValueFor: self environmentVariableName orElse: 'unknown'
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> description [
	^ self environmentVariableName , ' environment variable'
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> environmentVariableName [
	^ self class environmentVariableName
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> supportsMultiple [
	^ false
]
