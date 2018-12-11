code generation - event
generateEventInitializeMethod
	| result methodName cr |
	cr := Character cr.
	methodName := 'initialize'.
	result := WriteStream with: String new.
	result nextPutAll: methodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	super initialize.';
		nextPut: cr.
	result
		nextPutAll: '	self aggregateRootClass: #';
		nextPutAll: self appName;
		nextPutAll: self aggregate;
		nextPut: $.;
		nextPut: cr.
	^ result contents