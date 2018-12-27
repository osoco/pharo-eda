code generation
generateTestHelperBuildEventClassMethodNameWithArgPrefix: prefix
	^ 'withAggregateId: ' , (prefix , 'Id') uncapitalized , ' commandId: ' , (prefix , 'CommandId') uncapitalized , ' andAttributes: ' , (prefix , 'Attributes') uncapitalized