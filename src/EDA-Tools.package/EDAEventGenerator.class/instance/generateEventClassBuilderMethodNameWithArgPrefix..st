code generation
generateEventClassBuilderMethodNameWithArgPrefix: prefix
	^ 'forTenant: ' , prefix , 'Tenant withAggregateId: ' , prefix
		, 'Id commandId: ' , prefix , 'CommandId andAttributes: ' , prefix
		, 'Attrs'