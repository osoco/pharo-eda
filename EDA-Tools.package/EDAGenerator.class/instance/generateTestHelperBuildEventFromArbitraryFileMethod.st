code generation - test trait
generateTestHelperBuildEventFromArbitraryFileMethod
	| result eventAttrs cr |
	cr := Character cr.
	eventAttrs := self
		retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream on: String new.
	result
		nextPutAll:
			(self	generateTestHelperBuildEventFromArbitraryFileMethodNameWithFileArg: 'aFile').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll:
			'	| eventMessage eventJson eventMeta eventBody evtAttributes evtCommandId evtId |';
		nextPut: cr.
	result
		nextPutAll: '	eventMessage := self ';
		nextPutAll: self generateReadEventFromFileTestHelperMethodName;
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	eventJson := NeoJSONReader fromString: eventMessage.';
		nextPut: cr.
	result
		nextPutAll: '	eventMeta := eventJson at: #meta.';
		nextPut: cr.
	result
		nextPutAll: '	eventBody := eventJson at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	evtAttributes := Dictionary new.';
		nextPut: cr.
	result
		nextPutAll: '	evtAttributes at: ''version'' put: (eventMeta at: ''version'').';
		nextPut: cr.
	result
		nextPutAll:
			'	evtAttributes at: ''aggregateRootVersion'' put: (eventBody at: ''version'').';
		nextPut: cr.
	result
		nextPutAll: '	evtId := eventBody at: ''id''.';
		nextPut: cr.
	result
		nextPutAll: '	evtCommandId := eventMeta at: ''correlationId'' ifAbsent: [ ''missing'' ].';
		nextPut: Character cr.
	eventAttrs
		do: [ :attr | 
			result
				nextPutAll: '	eventBody at: ''';
				nextPutAll: attr uncapitalized;
				nextPutAll: ''' ifPresent: [ :v | evtAttributes at: ''';
				nextPutAll: attr uncapitalized;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: (self toCamelCase: self eventName);
		nextPut: Character space;
		nextPutAll: (self generateTestHelperBuildEventClassMethodNameWithArgPrefix: 'evt');
		nextPut: cr.
	^ result contents