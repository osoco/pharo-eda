Trait {
	#name : #EDATPrintOnHelper,
	#category : #'EDA-Traits'
}

{ #category : #helpers }
EDATPrintOnHelper >> asDictionary [
	| result |
	result := Dictionary new.
	self class allInstVarNames
		do:
			[ :varName | result add: varName -> (self instVarNamed: varName) ].
	^ result
]

{ #category : #helpers }
EDATPrintOnHelper >> jsonWriteOn: stream [
	^ self asDictionary jsonWriteOn: stream
]

{ #category : #helpers }
EDATPrintOnHelper >> printOn: stream [
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
]
