code generation
generateCommandClassBuilderMethodNameWithArgPrefix: prefix
	^ 'forTenant: ' , prefix , 'Tenant withCommandId: ' , prefix , 'CommandId aggregateRootVersion: '
		, prefix , 'Version andAttributes: ' , prefix , 'Attributes'