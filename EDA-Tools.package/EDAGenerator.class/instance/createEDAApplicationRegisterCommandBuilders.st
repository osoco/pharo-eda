code generation - EDAApplication
createEDAApplicationRegisterCommandBuilders
	^ self
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: self generateEDAApplicationRegisterCommandBuildersMethod
		inClass: (self appName , 'EDAApplication') asSymbol asClass class
		classifiedAs: 'setup - commands' asSymbol