code generation
generateTestHelperBuildEventClassMethodNameWithArgPrefix: prefix
	^ 'forTenant: ' , (prefix , 'Tenant') , ' withAggregateId: '
		, (prefix , 'Id') uncapitalized , ' commandId: '
		, (prefix , 'CommandId') uncapitalized , ' andAttributes: '
		, (prefix , 'Attributes') uncapitalized