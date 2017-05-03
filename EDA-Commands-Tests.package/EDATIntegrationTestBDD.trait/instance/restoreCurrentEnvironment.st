lifecycle
restoreCurrentEnvironment
	self currentEnvironment
		ifNotNil: [ :environmentValueToRestore |
			OSPlatform current environment
				at: EDADUEnvironment environmentVariableName
				put: environmentValueToRestore ]