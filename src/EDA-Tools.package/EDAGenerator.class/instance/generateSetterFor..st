code generation
generateSetterFor: attribute
	^ attribute
		,
			': newValue
',	self generateSignature, '	', attribute , ' := newValue'