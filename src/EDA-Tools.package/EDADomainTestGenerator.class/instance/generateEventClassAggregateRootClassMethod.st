delegated
generateEventClassAggregateRootClassMethod
	| delegate |
	delegate := EDAEventGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		andEventNameResolver: self eventNameResolver.
	^ delegate generateEventClassAggregateRootClassMethod