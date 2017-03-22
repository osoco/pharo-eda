code generation
generateEventClassBuilderMethodName
	| eventClass result attrs |
	eventClass := self retrieveEventClassName asSymbol.
	result := 'withCommandId:'.
	attrs := self retrieveEventAttributesBut: (EDAGenerator skippedEventAttributes).
	attrs
		doWithIndex: [ :attr :i | 
			| capitalized |
			capitalized := attr capitalized.
			result := result , attr , ':' ].
	^ result