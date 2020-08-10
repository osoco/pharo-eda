code generation
generateAggregateHandleCommandMethod
	| result commandClass attrs cr |
	cr := Character cr.
	commandClass := self retrieveCommandClassName asSymbol.
	attrs := self
		allAttributesOf: (self class environment at: commandClass)
		including: self retrieveCommandAttributes.
	result := WriteStream with: String new.
	result
		nextPutAll: (self generateAggregateHandleCommandMethodNameWithArg: 'aCommand');
		nextPut: cr.
	result
		nextPutAll: '	<useAsCommandHandlerFor: #';
		nextPutAll: commandClass;
		nextPut: $>;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| theId theCommandId theAttrs |';
		nextPut: cr.
	(self commandContainsAttribute: 'id')
		ifTrue: [ result nextPutAll: '	theId := aCommand aggregateRootId.' ]
		ifFalse: [ result nextPutAll: '	theId := UUID new greaseString.' ].
	result nextPut: cr.
	result
		nextPutAll: '	theCommandId := aCommand commandId.';
		nextPut: cr.
	result
		nextPutAll: '	theAttrs := self class buildCommonArgsForCommand: aCommand.';
		nextPut: cr.
	(attrs
		reject: [ :attr | 
			self class skippedEventAttributes
				anySatisfy: [ :skipped | attr = skipped ] ])
		do: [ :attr | 
			result
				nextPutAll: '	aCommand ';
				nextPutAll: attr;
				nextPutAll: ' ifNotNil: [ :v | theAttrs at: ''';
				nextPutAll: attr;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result
		nextPutAll: '	^ ';
		nextPutAll: appName;
		nextPutAll: (self toCamelCase: self eventName);
		nextPut: cr.
	result
		nextPutAll: '		';
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: cr.
	^ result contents