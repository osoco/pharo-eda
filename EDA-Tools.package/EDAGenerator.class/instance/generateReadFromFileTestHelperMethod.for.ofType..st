code generation - test trait
generateReadFromFileTestHelperMethod: methodName for: resourceName ofType: type
	| result cr relativeFolders |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: methodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	^ self readFile: (FileSystem disk workingDirectory '.
	relativeFolders := (self findRelativePathBetweenFile: self commandFile andFolder: FileSystem disk workingDirectory).
	relativeFolders removeLast;removeLast.
	relativeFolders
		do: [ :subfolder | 
			result
				nextPutAll: ' / ''';
				nextPutAll: subfolder;
				nextPutAll: '''' ].
	result
		nextPutAll: ' / ''';
		nextPutAll: type;
		nextPutAll: ''' / ''v';
		nextPutAll: self version greaseString;
		nextPutAll: ''' / ''';
		nextPutAll: (self upcasedToDotSeparated: resourceName);
		nextPutAll: '.example.json'')';
		nextPut: cr.
	^ result contents