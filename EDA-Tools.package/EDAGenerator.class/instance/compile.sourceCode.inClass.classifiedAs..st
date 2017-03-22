compilation
compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol
	(self isMethod: methodName markedAsDisableRegenerationInClass: aClass)
		ifFalse: [ aClass compile: method classified: protocol ]