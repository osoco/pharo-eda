compilation
checkBytecodeHash: methodName sourceCode: method inClass: aClass
	| existingClass existingMethod result |
	existingClass := (self class environment at: aClass name asSymbol ifAbsent: nil).
	existingMethod := existingClass ifNil: [ nil ] ifNotNil: [ :c | c methodDictionary at: methodName asSymbol ifAbsent: [ nil ] ].
	result := existingMethod isNotNil.
	result
		ifTrue: [ | tempClass generatedMethod |
			tempClass := Object
				subclass: (aClass greaseString , 'Temp') asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'EDA-Tools-Temp'.
			tempClass compile: method classified: #temp.
			generatedMethod := tempClass methodDictionary at: methodName asSymbol.
			result := generatedMethod bytecodesHash = existingMethod bytecodesHash.
			tempClass removeFromSystem ].
	^ result