code generation - DefaultCommandBuilder
createDefaultCommandBuilderInitializeCommandBuildersFor: appName
	| generator |
	generator := self new.
	^ generator
		compile: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName
		sourceCode: (self generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: appName)
		inClass:
			(self class environment
				at: (appName , 'DefaultCommandBuilder') asSymbol)
		classifiedAs: generator protocol