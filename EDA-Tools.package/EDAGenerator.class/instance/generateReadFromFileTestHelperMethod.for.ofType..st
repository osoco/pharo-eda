code generation - test trait
generateReadFromFileTestHelperMethod: methodName for: resourceName ofType: type
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: methodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| file result |';
		nextPut: cr.
	result
		nextPutAll: '	file := (FileSystem disk workingDirectory / ''contracts'' / ''BBVA-ATS'' / ''';
		nextPutAll: type;
		nextPutAll: ''' / ''v';
		nextPutAll: self version greaseString;
		nextPutAll: ''' / ''';
		nextPutAll: (self upcasedToDotSeparated: resourceName);
		nextPutAll: '.example.json'') readStream.';
		nextPut: cr.
	result
		nextPutAll: '	result := file contents.';
		nextPut: cr.
	result
		nextPutAll: '	file close.';
		nextPut: cr.
	result nextPutAll: '	^ result'.
	^ result contents