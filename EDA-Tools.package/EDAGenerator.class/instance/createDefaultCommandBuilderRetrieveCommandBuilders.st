code generation - DefaultCommandBuilder
createDefaultCommandBuilderRetrieveCommandBuilders
	^ self compile: self generateDefaultCommandBuilderRetrieveCommandBuildersMethodName sourceCode: self generateDefaultCommandBuilderRetrieveCommandBuildersMethod  inClass: (self appName , 'DefaultCommandBuilder') asSymbol asClass classifiedAs: 'initialization' asSymbol