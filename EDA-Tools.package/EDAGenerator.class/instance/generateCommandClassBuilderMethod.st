code generation - command
generateCommandClassBuilderMethod
	| result attrs |
	attrs := self retrieveCommandAttributes.
	attrs size > EDAGenerator maxMethodParams
		ifTrue: [ result := self generateLongParamsCommandBuilderClassMethod ]
		ifFalse: [ result := self generateShortParamsCommandBuilderClassMethod ].
		^ result