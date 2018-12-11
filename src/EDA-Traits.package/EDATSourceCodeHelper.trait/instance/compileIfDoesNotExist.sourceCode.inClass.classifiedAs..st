compilation
compileIfDoesNotExist: methodName sourceCode: method inClass: aClass classifiedAs: protocol
	aClass methodDictionary
		at: methodName asSymbol
		ifAbsent: [ self
				compile: methodName
				sourceCode: method
				inClass: aClass
				classifiedAs: protocol ]