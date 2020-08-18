code generation
generateCommandClassBuilderMethodNameWithArgPrefix: prefix
	^ 'ofTenant: ' , prefix , 'Tenant withCommandId: ' , prefix
		, 'CommandId aggregateRootVersion: ' , prefix
		, 'Version andAttributes: ' , prefix , 'Attributes'