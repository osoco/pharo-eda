code generation
generateEventClassBuilderMethodNameWithArgPrefix: prefix
	^ self generateEventClassBuilderMethodNameWithCommandArg: prefix , 'CommandId' andBlock: [ :attr | prefix , attr capitalized ]