handling
writeCommand: aCommand withBasename: aBasename
	| result |
	result := (self class errorFolderFor: aBasename)
		/ (aCommand class printString , '.txt').
	result writeStream
		nextPutAll: aCommand printString;
		close.
	^ result