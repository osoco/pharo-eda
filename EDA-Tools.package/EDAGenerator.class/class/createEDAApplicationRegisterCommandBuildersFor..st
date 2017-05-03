code generation - EDAApplication
createEDAApplicationRegisterCommandBuildersFor: appName
	| generator |
	generator := self new.
	^ generator
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: (self generateEDAApplicationRegisterCommandBuildersMethodFor: appName)
		inClass:
			(self class environment at: (appName , 'EDAApplication') asSymbol) class
		classifiedAs: generator protocol