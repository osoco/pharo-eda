lifecycle
restoreOriginalEnvironment
	(self currentEnvironment = self originalEnvironment)
		ifFalse:
			[ self originalEnvironment ifNotNil: [ :environmentValueToRestore | self currentEnvironment: environmentValueToRestore. OSPlatform current environment at: EDADUEnvironment environmentVariableName put: environmentValueToRestore ] ]