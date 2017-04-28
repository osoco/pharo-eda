code generation - test support
generateTestHelperBuildEventClassMethod
	| result methodName method attrs cr |
	cr := Character cr.
	methodName := self generateTestHelperBuildEventClassMethodName.
	method := WriteStream with: String new.
	method nextPutAll: (self generateTestHelperBuildEventClassMethodNameWithArgPrefix: 'new').
	method nextPutAll: self generateSignature.
	attrs := self retrieveEventAttributesBut: self class skippedEventAttributes.
	method nextPut: cr.
	method
		nextPutAll: '	| result | ';
		nextPut: cr.
	method
		nextPutAll: '	result := self new.';
		nextPut: cr.
	method
		nextPutAll: '	result id: UUID new asString.';
		nextPut: cr.
	method
		nextPutAll: '	result commandId: newCommandId.';
		nextPut: cr.
	method
		nextPutAll: '	result aggregateRootClass: #';
		nextPutAll: self appName;
		nextPutAll: self aggregate;
		nextPut: $.;
		nextPut: cr.
	method nextPutAll: '	result timestamp: DateAndTime now asUTC.'.
	attrs
		do: [ :attr |
			method
				nextPut: cr;
				nextPutAll: '	result ';
				nextPutAll: attr;
				nextPutAll: ': new';
				nextPutAll: attr capitalized;
				nextPut: $. ].
	method nextPut: cr.
	method nextPutAll: '	^ result'.
	result := Dictionary new.
	result at: methodName put: method contents.
	^ result