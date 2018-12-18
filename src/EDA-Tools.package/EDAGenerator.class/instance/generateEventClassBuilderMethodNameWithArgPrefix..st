code generation - event
generateEventClassBuilderMethodNameWithArgPrefix: prefix
	^ 'withAggregateId: ' , prefix , 'Id commandId: ' , prefix , 'CommandId andAttributes: '
		, prefix , 'Attrs'