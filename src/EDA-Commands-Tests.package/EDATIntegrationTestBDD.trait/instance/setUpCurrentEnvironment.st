lifecycle
setUpCurrentEnvironment
	self isEnvironmentIntegrationTest
		ifFalse: [ OSPlatform current environment at: EDADUEnvironment environmentVariableName put: 'integration-tests' ]