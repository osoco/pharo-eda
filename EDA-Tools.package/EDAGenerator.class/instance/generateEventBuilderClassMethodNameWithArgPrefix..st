code generation - event
generateEventBuilderClassMethodNameWithArgPrefix: prefix
	^ self generateEventBuilderClassMethodNameWithCommandArg: prefix , 'CommandId' andBlock: [ :attr | prefix , attr capitalized ]