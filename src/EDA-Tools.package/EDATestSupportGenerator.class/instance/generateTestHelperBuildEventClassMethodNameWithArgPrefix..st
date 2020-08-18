code generation
generateTestHelperBuildEventClassMethodNameWithArgPrefix: prefix
	^ 'ofTenant: ' , (prefix , 'Tenant') , ' withAggregateId: '
		, (prefix , 'Id') uncapitalized , ' commandId: '
		, (prefix , 'CommandId') uncapitalized , ' andAttributes: '
		, (prefix , 'Attributes') uncapitalized