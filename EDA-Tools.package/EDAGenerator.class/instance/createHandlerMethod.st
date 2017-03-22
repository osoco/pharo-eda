compilation
createHandlerMethod
	^ self compileIfDoesNotExist: self generateHandlerMethodName sourceCode: self generateHandlerMethod inClass:  (self appName , self aggregate capitalized) asSymbol asClass classifiedAs: 'command handling' asSymbol