instance creation
fromExampleFile: aFile version: version appName: appName aggregate: aggregate
	^ self
		fromExampleFile: aFile
		version: version
		appName: appName
		aggregate: aggregate
		andEventNameResolver: DefaultEnglishEventNameResolver new