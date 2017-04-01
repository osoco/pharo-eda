code generation - event
generateEventBuilderClassMethodNameWithCommandArg: commandArg andBlock: block
	| eventClass result attrs |
	eventClass := self retrieveEventClassName asSymbol.
	result := 'withCommandId: ' , commandArg , ' '.
	attrs := self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes.
	attrs
		do: [ :attr |
			result := result , attr , ': ' , (block cull: attr) , ' ' ].
	^ result