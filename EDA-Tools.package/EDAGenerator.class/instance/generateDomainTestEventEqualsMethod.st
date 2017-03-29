code generation
generateDomainTestEventEqualsMethod
	| result |
	result := '= anInstance' , String cr.
	result := result , '    ^ ' , self retrieveEventClassName , ' = anInstance class and: [ ' , (self generateDomainTestEventEqualsAndBlockRecursively: self retrieveEventAttributes) , ' ].'.
	^ result