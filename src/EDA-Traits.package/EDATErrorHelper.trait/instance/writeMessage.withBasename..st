handling
writeMessage: aString withBasename: aBasename
	| file stderr stream result |
	result := aBasename , '.message.txt'.
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing message ';
		nextPutAll: result;
		nextPut: Character cr.
	file := FileSystem disk workingDirectory / result.
	stream := file writeStream.
	stream nextPutAll: aString.
	stream close.
	^ result