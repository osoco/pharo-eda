code generation - event
generateEventBuilderClassMethod
	| result attrs |
	attrs := self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes.
	attrs size > EDAGenerator maxMethodParams
		ifTrue: [ result := self generateLongParamsEventBuilderClassMethod ]
		ifFalse: [ result := self generateShortParamsEventBuilderClassMethod ].
	^ result