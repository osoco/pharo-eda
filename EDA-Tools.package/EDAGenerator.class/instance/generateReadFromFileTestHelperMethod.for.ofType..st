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
		nextPutAll: '	^ self readFile: (FileSystem disk workingDirectory / ''contracts'' / ''BBVA-ATS'' / ''';
		nextPutAll: type;
		nextPutAll: ''' / ''v';
		nextPutAll: self version greaseString;
		nextPutAll: ''' / ''';
		nextPutAll: (self upcasedToDotSeparated: resourceName);
		nextPutAll: '.example.json'')';
		nextPut: cr.
	^ result contents