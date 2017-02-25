lifecycle
restoreCurrentEnvironment
	self currentEnvironment
		ifNotNilDo: [ :environmentValueToRestore |
			OSPlatform current environment
				at: EDADUEnvironment environmentVariableName
				put: environmentValueToRestore ]
