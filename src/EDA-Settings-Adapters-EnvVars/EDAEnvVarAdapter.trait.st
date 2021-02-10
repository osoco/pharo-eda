Trait {
	#name : #EDAEnvVarAdapter,
	#category : #'EDA-Settings-Adapters-EnvVars'
}

{ #category : #'environment-variables' }
EDAEnvVarAdapter >> getValueFor: envVarName orElse: defaultValue [
	^ OSPlatform current environment
		at: envVarName
		ifAbsent: defaultValue
]
