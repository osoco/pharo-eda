delegated
generateDomainTestMethodName
	| delegate |
	delegate := EDADomainTestGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		andEventNameResolver: self eventNameResolver.
	^ delegate generateDomainTestMethodName
