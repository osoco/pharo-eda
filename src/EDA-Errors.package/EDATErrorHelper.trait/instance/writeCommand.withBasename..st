handling
writeCommand: aString withBasename: aBasename
	| result |
	result := (self class errorFolderFor: aBasename) / 'command.txt'.
	(WriteStream on: result)
		nextPutAll: aString;
		close.
	^ result