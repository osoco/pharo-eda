code generation - test trait
generateTestHelperBuildCommandMethod
	| result cr commandAttrs cmdName |
	cr := Character cr.
	commandAttrs := self retrieveCommandAttributes.
	cmdName := self toCamelCase: self commandName.
	result := WriteStream with: String new.
	result nextPutAll: self generateTestHelperBuildCommandMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    | commandMessage commandJson commandMeta commandBody cmdCommandId cmdVersion cmdContractVersion cmdAttributes result |';
		nextPut: cr.
	result
		nextPutAll: '	commandMessage := self read';
		nextPutAll: (self toCamelCase: cmdName);
		nextPutAll: 'FromFile.';
		nextPut: cr.
	result
		nextPutAll: '	commandJson := NeoJSONReader fromString: commandMessage.';
		nextPut: cr.
	result
		nextPutAll: '	commandMeta := commandJson at: #meta.';
		nextPut: cr.
	result
		nextPutAll: '	commandBody := commandJson at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	cmdCommandId := commandMeta at: ''id'' ifPresent: [ :v | v ] ifAbsent: [ UUID new greaseString ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes := Dictionary new.';
		nextPut: cr.
	result
		nextPutAll: '	cmdContractVersion := commandMeta at: ''version'' ifAbsent: [ ';
		nextPutAll: self version greaseString;
		nextPutAll: ' ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes at: ''version'' put: cmdContractVersion.';
		nextPut: cr.
	result
		nextPutAll: '	cmdVersion := commandBody at: ''version'' ifAbsent: [ 0 ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes at: ''aggregateRootVersion'' put: cmdVersion.';
		nextPut: cr.
	(commandAttrs select: [ :a | a ~= 'version' ])
		do: [ :attr | 
			result
				nextPutAll: '	commandBody at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | cmdAttributes at: ''';
				nextPutAll: attr;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result nextPutAll: '	result := '.
	self isDeleteCommand
		ifTrue: [ 
			result
				nextPutAll: 'EDADeleteAggregateCommand'
		] ifFalse: [
			result
				nextPutAll: self appName;
				nextPutAll: cmdName
		].
	result
		nextPut: Character space;
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'cmd');
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	commandBody at: ''id'' ifPresent: [ :v | result aggregateRootId: v ].';
		nextPut: cr.
	result
		nextPutAll: '	result version: cmdContractVersion.';
		nextPut: cr.
	result
		nextPutAll: '	result aggregateRootVersion: cmdVersion.';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
			nextPut: cr.
	^ result contents