instance creation
scannerPragma: aSymbol from: aClass
	^ self new
		pragma: aSymbol;
		fromClass: aClass;
		yourself