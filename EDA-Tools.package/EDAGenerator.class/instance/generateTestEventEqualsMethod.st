code generation - test support
generateTestEventEqualsMethod
	| result |
	result := '= anInstance' , String cr.
	result := result , '    ^ ' , self retrieveEventClassName , ' = anInstance class and: [ ' , (self generateTestEventEqualsAndBlockRecursively: self retrieveEventAttributes) , ' ].'.
	^ result