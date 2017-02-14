lifecycle
setUpCurrentEnvironment
	self currentEnvironment: (OSPlatform current environment at: EDADUEnvironment environmentVariableName ifAbsent: [ ]).
	self currentEnvironment = 'integration-tests'
		ifFalse: [ OSPlatform current environment at: EDADUEnvironment environmentVariableName put: 'integration-tests' ]