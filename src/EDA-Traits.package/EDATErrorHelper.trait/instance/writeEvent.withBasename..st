handling
writeEvent: aString withBasename: aBasename
	| file stderr result |
	result := aBasename , '.event.txt'.
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing event ';
		nextPutAll: result;
		nextPut: Character cr.
	file := FileSystem disk workingDirectory / result.
	file writeStream
		nextPutAll: aString;
		close.
	^ result