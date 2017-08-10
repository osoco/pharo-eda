code generation - command
generateCommandClassBuilderMethodNameWithArgPrefix: prefix
	^ 'withCommandId: ' , prefix , 'CommandId aggregateRootVersion: ' , prefix , 'Version andAttributes: ' , prefix , 'Attributes'