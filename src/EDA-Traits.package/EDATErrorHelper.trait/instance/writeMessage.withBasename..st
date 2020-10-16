handling
writeMessage: aString withBasename: aBasename
	| result |
	result := (self class errorFolderFor: aBasename) / 'message.txt'.
	result writeStream
		nextPutAll: aString;
		close.
	^ result