code generation
generateEventClassLatestVersionMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result nextPutAll: self generateEventClassLatestVersionMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
			nextPutAll: self version greaseString;
		nextPut: cr.
	^ result contents