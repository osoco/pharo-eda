delegated
createTestHelperBuildEventMethod
	| delegate |
	delegate := EDATestTraitGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestHelperBuildEventMethod