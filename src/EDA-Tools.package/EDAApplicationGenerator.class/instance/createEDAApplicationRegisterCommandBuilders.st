code generation
createEDAApplicationRegisterCommandBuilders
	^ self
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: (self generateEDAApplicationRegisterCommandBuildersMethodFor: self appName)
		inClass: (self class environment at: (appName , 'EDAApplication') asSymbol) class
		classifiedAs: self protocol