helpers
printOn: stream
	| firstVar |
	firstVar := true.
	self class allInstVarNames
		do: [ :varName |
			firstVar
				ifTrue: [ stream nextPutAll: '{ '. firstVar := false ]
				ifFalse: [ stream nextPutAll: ', ' ].
			stream nextPut: $"; nextPutAll: varName; nextPutAll: '": "'; nextPutAll: (self instVarNamed: varName) greaseString; nextPut: $" ].
	stream nextPutAll: ' }'.
	^ self