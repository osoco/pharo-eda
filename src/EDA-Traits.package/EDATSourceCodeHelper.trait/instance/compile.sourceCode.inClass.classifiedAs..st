compilation
compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol
	| compile |
	self flag: #TODO. "Disabled checkBytecodeHash:sourceCode:inClass: since it doesn't help figuring out if a method changes only by a signature timestamp"
	compile := (self isMethod: methodName markedAsDisableRegenerationInClass: aClass) not.
	"compile := compile
		ifTrue: [ (self checkBytecodeHash: methodName sourceCode: method inClass: aClass) not ]
		ifFalse: [ false ]."
	compile
		ifTrue: [ | existingMethod |
			existingMethod := aClass methodDictionary at: methodName asSymbol ifAbsent: [ nil ].
			existingMethod ifNil: [ compile := true ] ifNotNil: [ :m | compile := m protocol greaseString beginsWithSubCollection: 'generated' ] ].
	compile
		ifTrue: [ aClass compile: method classified: protocol ]