handling
writeMessage: aString withBasename: aBasename
	| file stderr serializer aStream result |
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing message ...';
		nextPut: Character cr.
	serializer := FLSerializer newDefault.
	serializer analyzer
		when: [ :o | o class isObsolete ]
		substituteBy: [ :o | nil ].
	aStream := GZipWriteStream on: (ByteArray new: 100).
	serializer serialize: aString on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized message';
		nextPut: Character cr.
	result := aBasename , '.message'.
	file := FileSystem disk workingDirectory / result.
	(WriteStream on: file) nextPutAll: aStream encodedStream contents.
	file close.
	^ result