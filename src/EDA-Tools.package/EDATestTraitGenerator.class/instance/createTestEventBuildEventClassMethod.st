delegated
createTestEventBuildEventClassMethod
	| delegate |
	delegate := EDATestSupportGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestEventBuildEventClassMethod