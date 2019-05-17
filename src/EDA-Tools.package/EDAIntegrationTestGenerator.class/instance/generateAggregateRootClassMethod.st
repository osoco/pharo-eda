code generation
generateAggregateRootClassMethod
	| result cr |
	result := WriteStream with: String new.
	cr := Character cr.
	result
		nextPutAll: self generateAggregateRootClassMethodName;
		nextPut: cr;
		nextPutAll: '	^ ';
		nextPutAll: (self appName , self aggregate capitalized);
		nextPut: cr.
	^ result contents