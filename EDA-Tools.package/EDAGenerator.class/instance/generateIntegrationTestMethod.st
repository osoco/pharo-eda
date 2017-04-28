code generation - integration test
generateIntegrationTestMethod
	| result evtAttrs evtName cr |
	cr := Character cr.
	result := WriteStream with: String new.
	evtAttrs := self retrieveEventAttributes.
	evtName := self toCamelCase: self eventName.
	result
		nextPutAll: self generateDomainTestMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| theCommandId commandFile commandMessage commandJson commandBody eventFile expectedMessage expectedRoutingKey '.
	evtAttrs
		do: [ :attr |
			result
				nextPutAll: 'evt';
				nextPutAll: attr capitalized;
				nextPut: Character space ].
	result
		nextPut: $|;
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
		nextPutAll: '	commandFile close.';
		nextPut: cr.
	result
		nextPutAll: '	theCommandId := UUID new asString.';
		nextPut: cr.
	result
		nextPutAll: '	commandBody := commandJson at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	eventFile := (FileSystem disk workingDirectory / ''contracts'' / ''BBVA-ATS'' / ''events'' / ''v1'' / ''';
		nextPutAll: (self upcasedToDotSeparated: self eventName);
		nextPutAll: '.example.json'') readStream.';
		nextPut: cr.
	result
		nextPutAll: '	expectedMessage := eventFile contents.';
		nextPut: cr.
	result
		nextPutAll: '	eventFile close.';
		nextPut: Character cr.
	result
		nextPutAll: '	expectedRoutingKey := ''';
		nextPutAll: (self upcasedToDotSeparated: self eventName);
		nextPut: $';
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	self';
		nextPut: cr.
	result
		nextPutAll: '		givenPreviousEvents: {}';
		nextPut: cr.
	result
		nextPutAll: '		whenReceiveCommandMessage: commandMessage';
		nextPut: cr.
	result
		nextPutAll: '		thenStoreEvent: (';
		nextPutAll: self appName;
		nextPutAll: evtName;
		nextPut: cr.
	result
		nextPutAll: '			';
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'evt');
		nextPut: $);
		nextPut: cr.
	result
		nextPutAll: '		andPublishEventMessage: expectedMessage';
		nextPut: cr.
	result
		nextPutAll: '		withRoutingKey: expectedRoutingKey';
		nextPut: cr.
	^ result contents