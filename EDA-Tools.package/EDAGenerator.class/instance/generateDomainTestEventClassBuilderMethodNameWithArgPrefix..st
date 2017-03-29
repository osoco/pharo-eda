code generation
generateDomainTestEventClassBuilderMethodNameWithArgPrefix: prefix
	^ 'fromEvent: event andId: ' , prefix , 'Id'