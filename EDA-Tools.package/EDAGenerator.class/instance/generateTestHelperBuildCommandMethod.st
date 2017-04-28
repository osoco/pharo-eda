code generation - test trait
generateTestHelperBuildCommandMethod
	| result cr commandAttrs cmdName |
	cr := Character cr.
	commandAttrs := self retrieveCommandAttributes.
	cmdName := (self toCamelCase: self commandName).
	result := WriteStream with: String new.
	result nextPutAll: self generateTestHelperBuildCommandMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    | commandFile commandMessage commandJson commandMeta commandBody cmdCommandId cmdVersion cmdAttributes |';
		nextPut: cr.
	result
		nextPutAll: '	commandFile := (FileSystem disk workingDirectory / ''contracts'' / ''BBVA-ATS'' / ''commands'' / ''v1'' / ''';
		nextPutAll: (self upcasedToDotSeparated: self commandName);
		nextPutAll: '.example.json'') readStream.';
		nextPut: cr.
	result
		nextPutAll: '	commandMessage := commandFile contents.';
		nextPut: cr.
	result
		nextPutAll: '	commandJson := NeoJSONReader fromString: commandMessage.';
		nextPut: cr.
	result
		nextPutAll: '	commandMeta := commandJson at: #meta.';
		nextPut: cr.
	result
		nextPutAll: '	commandFile close.';
		nextPut: cr.
	result
		nextPutAll: '	commandBody := commandJson at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	cmdCommandId := commandMeta at: ''id'' ifPresent: [ :v | v ] ifAbsent: [ UUID new greaseString ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdVersion := commandBody at: ''version'' ifAbsent: [ 1 ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes := Dictionary new.';
		nextPut: cr.
	commandAttrs
		do: [ :attr |
			result
				nextPutAll: '	commandBody at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | cmdAttributes at: ''';
				nextPutAll: attr;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: cmdName;
		nextPut: Character space;
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'cmd');
		nextPut: cr.
	^ result contents