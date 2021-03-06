code generation
generateCommandClassBuilderMethod
	| method attrs result cr cls |
	cr := Character cr.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: cr.
	cls := self class environment
		at: self retrieveCommandClassName asSymbol.
	attrs := self
		allAttributesOf: cls
		including:
			(self
				retrieveCommandAttributesBut: self class skippedCommandAttributes).
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
	method nextPutAll: '	result := super '.
	method
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: $.;
		nextPut: cr.
	method
		nextPutAll: '	result version: ';
		nextPutAll: self version greaseString;
		nextPut: $.;
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
	result
		at: self generateCommandClassBuilderMethodName
		put: method contents.
	^ result