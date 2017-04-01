code generation - command
generateCommandClassBuilderMethodNameWithArgPrefix: prefix
	| result attrs |
	attrs := self retrieveCommandAttributes.
		result := self
				generateCommandClassBuilderMethodNameWithCommandArg: prefix , 'CommandId'
				andBlock: [ :attr | prefix , attr capitalized ].
	^ result