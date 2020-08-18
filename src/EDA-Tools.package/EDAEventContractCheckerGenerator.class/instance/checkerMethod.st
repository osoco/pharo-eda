code generation
checkerMethod
	| result cr body |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self checkerMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| contract eventClass event id commandId attrs |';
		nextPut: cr.
	result
		nextPutAll: '	contract := self readEventFromContract: ''';
		nextPutAll: self eventFile basename;
		nextPutAll: ''' version: ';
		nextPutAll: self version greaseString;
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	eventClass := ''';
		nextPutAll: self retrieveEventClassName;
		nextPutAll: '''.';
		nextPut: cr.
	body := self eventJson at: #body.
	result
		nextPutAll: '	id := UUID new greaseString.';
		nextPut: cr.
	result
		nextPutAll: '	commandId := UUID new greaseString.';
		nextPut: cr.
	result
		nextPutAll: '	attrs := contract at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	event := ';
		nextPutAll: self appName;
		nextPutAll: 'Test';
		nextPutAll:
			(self
				remove: self appName
				fromBeginningOf: self retrieveEventClassName);
		nextPutAll:
			' fromEvent: ((self class environment at: eventClass asSymbol) ofTenant: (attrs at: ''tenant'' ifAbsent: [ nil ]) withAggregateId: id commandId: commandId andAttributes: attrs).';
		nextPut: cr.
	result
		nextPutAll: '	self assert: (event attribute: event id matches: id).';
		nextPut: cr.
	result
		nextPutAll: '	self assert: (event attribute: event commandId matches: commandId).';
		nextPut: cr.
	(body associations
		reject: [ :assoc |
			self class skippedEventAttributes
				anySatisfy: [ :attr | attr = assoc key ] ])
		do: [ :assoc | 
			result
				nextPutAll: '	self assert: (event attribute: event ';
				nextPutAll: assoc key;
				nextPutAll: ' matches: (attrs at: ''';
				nextPutAll: assoc key;
				nextPutAll: '''))';
				nextPut: $.;
				nextPut: cr ].
	result nextPut: cr.
	^ result contents
