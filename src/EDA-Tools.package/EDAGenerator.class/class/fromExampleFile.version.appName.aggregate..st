instance creation
fromExampleFile: aFile version: version appName: appName aggregate: aggregate
	^ self
		fromExampleFile: aFile
		version: version
		appName: appName
		aggregate: aggregate
		commandNameResolver: DefaultEnglishCommandNameResolver new
		andEventNameResolver: DefaultEnglishEventNameResolver new