code generation
generateAccessorsFor: attributes
	| result |
	result := Dictionary new.
	attributes
		do: [ :attr | 
			result at: (attr , ':') asSymbol put: (self generateSetterFor: attr).
			result at: attr asSymbol put: (self generateGetterFor: attr) ].
	^ result