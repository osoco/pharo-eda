code generation
generateAccessorsFor: cls attributes: attributes
	| result |
	result := Dictionary new.
	(attributes select: [ :attr | cls instVarNames anySatisfy: [ :a | a = attr ] ])
		do: [ :attr |
			result at: (attr , ':') asSymbol put: (self generateSetterFor: attr).
			result at: attr asSymbol put: (self generateGetterFor: attr) ].
	^ result