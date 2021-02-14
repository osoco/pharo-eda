Trait {
	#name : #EDATEnvVarAdapter,
	#category : #'EDA-Settings-Adapters-EnvVars'
}

{ #category : #'environment-variables' }
EDATEnvVarAdapter >> getValueFor: envVarName orElse: defaultValue [
	^ OSPlatform current environment
		at: envVarName
		ifAbsent: defaultValue
]

{ #category : #'environment-variables' }
EDATEnvVarAdapter >> isReadOnly [
	^ true
]
