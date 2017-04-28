code generation - test support
createTestEventBuildEventClassMethod
	| method |
	method := self generateTestEventBuildEventClassMethod.
	method
		associationsDo: [ :assoc | 
			^ self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: (self class environment at: (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol) class
				classifiedAs: self protocol ]