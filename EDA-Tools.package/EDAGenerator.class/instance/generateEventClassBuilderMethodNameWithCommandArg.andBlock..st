code generation
generateEventClassBuilderMethodNameWithCommandArg: commandArg andBlock: block
	| eventClass result attrs |
	eventClass := self retrieveEventClassName asSymbol.
	result := 'withCommandId: ' , commandArg , ' '.
	attrs := self retrieveEventAttributesBut: (EDAGenerator skippedEventAttributes).
	attrs
		doWithIndex: [ :attr :i |
			| capitalized |
			capitalized := attr capitalized.
			result := result , attr , ': ' , (block cull: attr) , ' ' ].
	^ result