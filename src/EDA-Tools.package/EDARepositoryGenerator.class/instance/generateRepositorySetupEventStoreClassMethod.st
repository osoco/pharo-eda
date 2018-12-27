code generation
generateRepositorySetupEventStoreClassMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result nextPutAll: self generateRepositorySetupEventStoreClassMethodName;
	nextPutAll: ' anEventStore';
	nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	EventStore := anEventStore';
		nextPut: cr.
	^ result contents