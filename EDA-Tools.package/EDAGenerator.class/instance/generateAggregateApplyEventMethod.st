code generation - aggregate
generateAggregateApplyEventMethod
	| result attrs cr cls |
	cr := Character cr.
	cls := (self appName , (self underscoreSeparatedToCamelCase: self aggregate)) asSymbol.
	attrs := self allAttributesOf: (self class environment at: cls) including: self retrieveEventAttributes.
	result := WriteStream with: String new.
	result
		nextPutAll: (self generateAggregateApplyEventMethodNameWithArg: 'anEvent');
		nextPut: cr.
	result nextPutAll: self generateSignature.
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