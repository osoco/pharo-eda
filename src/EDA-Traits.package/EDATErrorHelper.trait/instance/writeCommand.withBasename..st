handling
writeCommand: aString withBasename: aBasename
	| file stderr result |
	result := aBasename , '.command.txt'.
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing command ';
		nextPutAll: result;
		nextPut: Character cr.
	file := FileSystem disk workingDirectory / result.
	(WriteStream on: file)
		nextPutAll: aString;
		close.
	^ result