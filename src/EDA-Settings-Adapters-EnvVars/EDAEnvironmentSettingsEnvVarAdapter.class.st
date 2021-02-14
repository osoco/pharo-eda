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
EDAEnvironmentSettingsEnvVarAdapter >> availableEnvironments [ 
	^ OrderedCollection with: (self currentEnvironment)
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> currentEnvironment [
	^ self getValueFor: self environmentVariableName orElse: 'unknown'
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> environmentVariableName [
	^ DUEnvironment environmentVariableName 
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> priority [
	^ 50
]

{ #category : #testing }
EDAEnvironmentSettingsEnvVarAdapter >> supportsMultiple [
	^ false
]
