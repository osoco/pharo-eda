code generation
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
			'	| eventMessage eventJson eventMeta eventBody evtAttributes evtCommandId evtId evtTimestamp |';
		nextPut: cr.
	result
		nextPutAll: '	eventMessage := self readFile: aFile.';
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
		nextPut: cr.
	result
		nextPutAll: '	evtTimestamp := eventBody at: ''timestamp'' ifAbsent: [ nil ].';
		nextPut: cr.
	result
		nextPutAll: '	evtTimestamp ifNil: [ evtTimestamp := eventMeta at: ''timestamp'' ifAbsent: [ nil ] ].';
		nextPut: cr.
	result
		nextPutAll: '	evtTimestamp ifNotNil: [ :t | evtAttributes at: ''timestamp'' put: evtTimestamp ].';
		nextPut: cr.
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