code generation - integration test
generateIntegrationTestMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateDomainTestMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| aggregateRootId previousEvents command commandMessage expectedEvent expectedMessage expectedRoutingKey | ';
		nextPut: cr.
	result
		nextPutAll: '	previousEvents := Array new.';
		nextPut: cr.
	result
		nextPutAll: '	command := self build';
		nextPutAll: (self toCamelCase: self commandName capitalized);
		nextPutAll: 'SampleCommand.';
		nextPut: cr.
	result
		nextPutAll: '	commandMessage := self read';
		nextPutAll: (self toCamelCase: self commandName capitalized);
		nextPutAll: 'FromFile.';
		nextPut: cr.
	result
		nextPutAll: '	aggregateRootId := command aggregateRootId.';
		nextPut: cr.
	result
		nextPutAll: '	expectedEvent := self build';
		nextPutAll: (self toCamelCase: self eventName capitalized);
		nextPutAll: 'SampleEventWithId: aggregateRootId';
		nextPutAll: ' andCommandId: command commandId.';
		nextPut: cr.
	result
		nextPutAll: '	expectedMessage := (EDAJsonEventSerializer new serialize: expectedEvent).';
		nextPut: cr.
	result
		nextPutAll: '	expectedRoutingKey := ''';
		nextPutAll: (self upcasedToDotSeparated: self commandName);
		nextPut: $';
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	self';
		nextPut: cr.
	result
		nextPutAll: '		givenPreviousEvents: previousEvents';
		nextPut: cr.
	result
		nextPutAll: '		whenReceiveCommandMessage: commandMessage';
		nextPut: cr.
	result
		nextPutAll: '		thenStoreEvent: expectedEvent';
		nextPut: cr.
	result
		nextPutAll: '		andPublishEventMessage: expectedMessage';
		nextPut: cr.
	result
		nextPutAll: '		withRoutingKey: expectedRoutingKey';
		nextPut: cr.
	^ result contents