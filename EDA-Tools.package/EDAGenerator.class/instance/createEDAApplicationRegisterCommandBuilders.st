code generation
createEDAApplicationRegisterCommandBuilders
	^ self
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: self generateEDAApplicationRegisterCommandBuildersMethod
		inClass: (self appName , 'EDAApplication') asSymbol asClass
		classifiedAs: 'setup - commands' asSymbol