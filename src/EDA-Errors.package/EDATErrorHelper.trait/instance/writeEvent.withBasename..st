handling
writeEvent: aString withBasename: aBasename
	| result |
	result := (self class errorFolderFor: aBasename) / 'event.txt'.
	result writeStream
		nextPutAll: aString;
		close.
	^ result