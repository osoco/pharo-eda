code generation
createEDAApplicationRegisterCommandBuilders
	self flag: #TODO.
"	^ self
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: self generateEDAApplicationRegisterCommandBuildersMethod
		inClass: (self appName , 'EDAApplication') asSymbol asClass
		classifiedAs: 'setup - commands' asSymbol"