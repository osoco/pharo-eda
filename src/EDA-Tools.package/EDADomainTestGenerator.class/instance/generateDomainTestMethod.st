code generation
generateDomainTestMethod
	| result cmdName evtName cr |
	cr := Character cr.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	result := WriteStream with: String new.
	result nextPutAll: self generateDomainTestMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| command event |';
		nextPut: cr.
	result
		nextPutAll: '	command := self build';
		nextPutAll: cmdName;
		nextPutAll: 'SampleCommand.';
		nextPut: cr.
	result
		nextPutAll: '	event := self build'.
	self isDeletedEvent
		ifTrue: [
			result
				nextPutAll: 'DeletedEventWithId: ''<ANYTHING>'' ';
				nextPutAll: 'andCommand: command.'
		] ifFalse: [
			result
				nextPutAll: evtName;
				nextPutAll: 'SampleEventWithId: ''<ANYTHING>'' ';
				nextPutAll: 'andCommandId: command commandId.'
		].
	result
		nextPut: cr.
	result
		nextPutAll: '	self';
		nextPut: cr.
	result
		nextPutAll: '		givenAggregate: #';
		nextPutAll: self appName;
		nextPutAll: self aggregate capitalized;
		nextPut: cr.
	result
		nextPutAll: '			withEvents: OrderedCollection new';
		nextPut: cr.
	result
		nextPutAll: '			whenReceiveCommand: command';
		nextPut: cr.
	result
		nextPutAll: '			thenEvent: event';
		nextPut: cr.
	^ result contents