code generation
generateSetterFor: attribute
	^ attribute
		,
			': newValue
	' , attribute , ' := newValue'