code generation - aggregate
createAggregateHandleCommandMethod
	^ self compileIfDoesNotExist: self generateHandleCommandMethodName sourceCode: self generateHandleCommandMethod inClass:  (self appName , self aggregate capitalized) asSymbol asClass classifiedAs: 'command handling' asSymbol