code generation - test support
createTestEventBuilderClassMethod
	| method |
	method := self generateTestEventBuilderClassMethod associations first.
	^ self
		compileIfDoesNotExist: method key
		sourceCode: method value
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass class
		classifiedAs: 'instance creation' asSymbol