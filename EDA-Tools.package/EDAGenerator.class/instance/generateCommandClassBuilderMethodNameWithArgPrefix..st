code generation
generateCommandClassBuilderMethodNameWithArgPrefix: prefix
	^ self
		generateCommandClassBuilderMethodNameWithCommandArg: prefix , 'CommandId'
		andBlock: [ :attr | prefix , attr capitalized ]