Extension { #name : #Dictionary }

{ #category : #'*EDA-Commands' }
Dictionary >> changeKey: oldKey to: newKey [
	self
		at: oldKey asSymbol
		ifPresent: [ :value |
			self
				at: newKey asSymbol
				put: value ].
	self removeKey: oldKey asSymbol ifAbsent: [  ].
	
]
