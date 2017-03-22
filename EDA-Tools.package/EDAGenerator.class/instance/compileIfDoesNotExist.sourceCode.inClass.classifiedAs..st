compilation
compileIfDoesNotExist: methodName sourceCode: method inClass: aClass classifiedAs: protocol
	aClass methodDict at: methodName asSymbol ifAbsent: [ self compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol ]