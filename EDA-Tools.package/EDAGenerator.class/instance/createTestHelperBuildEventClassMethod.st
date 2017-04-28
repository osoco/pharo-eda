code generation - test support
createTestHelperBuildEventClassMethod
	| method |
	method := self generateTestHelperBuildEventClassMethod.
	method
		associationsDo: [ :assoc |
			^ self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: (self class environment at: self retrieveTestHelperTraitName asSymbol) class
				classifiedAs: self protocol ]