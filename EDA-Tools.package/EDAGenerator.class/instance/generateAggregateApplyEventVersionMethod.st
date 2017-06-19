code generation - aggregate
generateAggregateApplyEventVersionMethod
	| result attrs cr cls |
	cr := Character cr.
	cls := (self appName , (self underscoreSeparatedToCamelCase: self aggregate)) asSymbol.
	attrs := self retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream with: String new.
	result
		nextPutAll: (self generateAggregateApplyEventVersionMethodNameWithArg: ' anEvent');
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	self id: anEvent id.';
		nextPut: cr.
	attrs
		do: [ :attr | 
			result
				nextPutAll: '	self ';
				nextPutAll: attr;
				nextPutAll: ': anEvent ';
				nextPutAll: attr;
				nextPut: $.;
				nextPut: cr ].
	^ result contents