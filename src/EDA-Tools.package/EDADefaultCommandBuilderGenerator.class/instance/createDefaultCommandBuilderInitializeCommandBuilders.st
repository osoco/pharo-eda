code generation
createDefaultCommandBuilderInitializeCommandBuilders
	^ self
		compile: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName
		sourceCode: (self generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: self appName)
		inClass: (self class environment at: (appName , 'DefaultCommandBuilder') asSymbol)
		classifiedAs: self protocol