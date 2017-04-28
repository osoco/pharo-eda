code generation - test support
generateTestEventBuildEventClassMethod
	| method attrs result cr |
	cr := Character cr.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateTestEventBuildEventClassMethodNameWithArgPrefix: 'new');
		nextPut: cr.
	method nextPutAll: self generateSignature.
	attrs := self retrieveEventAttributesBut: self class skippedCommandAttributes.
	method
		nextPut: cr;
		nextPutAll: '	| result |';
		nextPut: cr.
	method
		nextPutAll: '	result := self new.';
		nextPut: cr.
	method
		nextPutAll: '	result id: ''<ANYTHING>''.';
		nextPut: cr.
	method
		nextPutAll: '	result commandId: newEvent commandId.';
		nextPut: cr.
	method
		nextPutAll: '	result aggregateRootClass: #';
		nextPutAll: self retrieveAggregateClassName;
		nextPut: $.;
		nextPut: cr.
	method
		nextPutAll: '	result aggregateRootVersion: ''<ANYTHING>''.';
		nextPut: cr.
	method nextPutAll: '	result timestamp: ''<ANYTHING>''.'.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	result ';
				nextPutAll: attr uncapitalized;
				nextPutAll: ': newEvent ';
				nextPutAll: attr;
				nextPut: $. ].
	method
		nextPut: cr;
		nextPutAll: '	^ result'.
	result := Dictionary new.
	result at: self generateTestEventBuildEventClassMethodName put: method contents.
	^ result