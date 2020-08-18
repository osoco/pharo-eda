code generation
generateEventClassBuilderMethodNameWithArgPrefix: prefix
	^ 'ofTenant: ' , prefix , 'Tenant withAggregateId: ' , prefix
		, 'Id commandId: ' , prefix , 'CommandId andAttributes: ' , prefix
		, 'Attrs'