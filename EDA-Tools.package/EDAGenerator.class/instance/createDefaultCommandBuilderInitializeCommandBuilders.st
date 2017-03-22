code generation
createDefaultCommandBuilderInitializeCommandBuilders
	^ self compile: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName sourceCode: self generateDefaultCommandBuilderInitializeCommandBuildersMethod  inClass: (self appName , 'DefaultCommandBuilder') asSymbol asClass classifiedAs: 'initialization' asSymbol
