delegated
createTestEventBuildEventClassMethod
	| delegate |
	delegate := EDADomainTestEventGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestEventBuildEventClassMethod