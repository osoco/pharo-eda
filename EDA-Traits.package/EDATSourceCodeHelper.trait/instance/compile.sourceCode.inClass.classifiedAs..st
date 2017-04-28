compilation
compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol
	| compile |
	compile := (self isMethod: methodName markedAsDisableRegenerationInClass: aClass) not.
	compile
		ifTrue: [ | existingMethod |
			existingMethod := aClass methodDictionary at: methodName asSymbol ifAbsent: [ nil ].
			existingMethod isNotNil ifTrue: [ compile := existingMethod protocol = #generated ] ].
	compile
		ifTrue: [ aClass compile: method classified: protocol ]