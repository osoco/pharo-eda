helper
generatedProtocolFor: aNumber
	| result |
	result := (aNumber ifNil: [ 'generated' ] ifNotNil: [ 'generated-v' , aNumber greaseString ]) asSymbol.
	^ result