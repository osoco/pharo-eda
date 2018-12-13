code generation
generateHashAndBlockRecursively: attributes
	| result |
	result := WriteStream with: String new.
	attributes isEmpty
		ifFalse: [ | wrap attribute |
			attribute := attributes first.
			wrap := attributes size > 1.
			wrap
				ifTrue: [ result nextPut: $( ].
			result
				nextPutAll: 'self ';
				nextPutAll: attribute;
				nextPutAll: ' hash'.
			attributes size > 1
				ifTrue: [ result
						nextPutAll: ' bitXor: ';
						nextPutAll: (self generateHashAndBlockRecursively: attributes allButFirst) ].
			wrap
				ifTrue: [ result nextPut: $) ] ].
	^ result contents