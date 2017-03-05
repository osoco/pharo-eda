lifecycle
restoreCurrentEnvironment
	OSPlatform current environment at: EDADUEnvironment environmentVariableName put: (self currentEnvironment ifNil: [ ^ 'test' ] ifNotNil: [ ^ self currentEnvironment ])