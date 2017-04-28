code generation
generateGetterFor: attribute
	^ attribute
		,
			'
' , self generateSignature , '	^ ' , attribute