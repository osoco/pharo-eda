code generation
generateCommandClassBuilderMethod
	| method attrs result cr cls |
	cr := Character cr.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: cr.
	cls := self class environment at: self retrieveCommandClassName asSymbol.
	attrs := self allAttributesOf: cls including: (self retrieveCommandAttributesBut: self class skippedCommandAttributes).
	method nextPutAll: self generateSignature.
	method
		nextPutAll: '	<';
		nextPutAll: appName asLowercase;
		nextPutAll: 'CommandName: #';
		nextPutAll: self commandName;
		nextPut: $>;
		nextPut: cr.
	method
		nextPutAll: '	| result |';
		nextPut: cr.
	method
		nextPutAll: '	result := self new.';
		nextPut: cr.
	method
		nextPutAll: '	result commandId: theCommandId.';
		nextPut: cr.
	method
		nextPutAll: '	result aggregateRootVersion: theVersion.';
		nextPut: cr.
	method
		nextPutAll: '	result version: (theAttributes at: ''version'' ifAbsent: [ ';
		nextPutAll: self version greaseString;
		nextPutAll: ' ]).';
		nextPut: cr.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	theAttributes at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | result ';
				nextPutAll: attr;
				nextPutAll: ': v ].' ].
	method nextPut: cr.
	method nextPutAll: '	^ result'.
	result := Dictionary new.
	result at: self generateCommandClassBuilderMethodName put: method contents.
	^ result