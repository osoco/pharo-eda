code generation
generateEqualsMethodFor: attributes
	| result |
	result := '= anInstance' , String cr.
	result := result , '    ^ self class = anInstance class and: [ '
		, (self generateEqualsAndBlockRecursively: attributes) , ' ].'.
	^ result