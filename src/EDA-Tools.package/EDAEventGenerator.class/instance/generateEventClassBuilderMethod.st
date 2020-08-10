code generation
generateEventClassBuilderMethod
	| result methodName method attrs cr cls |
	cr := Character cr.
	methodName := self generateEventClassBuilderMethodName.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'the').
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	attrs := self
		allAttributesOf: cls
		including: (self retrieveEventAttributesBut: self class skippedEventAttributes).
	method nextPut: cr.
	method nextPutAll: self generateSignature.
	method
		nextPutAll: '	| result | ';
		nextPut: cr.
	method nextPutAll: '	result := super '.
	method
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: $.;
		nextPut: cr.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	theAttrs at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | result ';
				nextPutAll: attr;
				nextPutAll: ': v ].' ].
	method nextPut: cr.
	method nextPutAll: '	^ result'.
	result := {(methodName -> method contents)} asDictionary.
	^ result