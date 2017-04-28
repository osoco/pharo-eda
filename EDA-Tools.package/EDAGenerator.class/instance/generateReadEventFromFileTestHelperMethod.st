code generation - test trait
generateReadEventFromFileTestHelperMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateReadEventFromFileTestHelperMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| eventFile result |';
		nextPut: cr.
	result
		nextPutAll: '	eventFile := (FileSystem disk workingDirectory / ''contracts'' / ''BBVA-ATS'' / ''events'' / ''v1'' / ''';
		nextPutAll: (self upcasedToDotSeparated: self eventName);
		nextPutAll: '.example.json'') readStream.';
		nextPut: cr.
	result
		nextPutAll: '	result := eventFile contents.';
		nextPut: cr.
	result
		nextPutAll: '	eventFile close.';
		nextPut: cr.
	result nextPutAll: '	^ result'.
	^ result contents