handling
writeCommand: aString withBasename: aBasename
	| result |
	result := (self class errorFolderFor: aBasename) / 'command.txt'.
	result writeStream
		nextPutAll: aString;
		close.
	^ result