handling
writeCommand: aCommand withBasename: aBasename
	| file stderr serializer aStream result |
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing command ...';
		nextPut: Character cr.
	serializer := FLSerializer newDefault.
	serializer analyzer
		when: [ :o | o class isObsolete ]
		substituteBy: [ :o | nil ].
	aStream := WriteStream on: (ByteArray new: 100).
	serializer serialize: aCommand on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized command';
		nextPut: Character cr.
	result := aBasename , '.command.txt'.
	file := FileSystem disk workingDirectory / result.
	file writeStream
		nextPutAll: aStream contents;
		close.
	^ result