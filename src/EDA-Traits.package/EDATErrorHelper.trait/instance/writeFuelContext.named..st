handling
writeFuelContext: aContext named: aString
	| file stderr serializer aStream |
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing fuel context to S3...';
		nextPut: Character cr.
	serializer := FLSerializer newDefault.
	serializer analyzer
		when: [ :o | o class isObsolete ]
		substituteBy: [ :o | nil ].
	aStream := GZipWriteStream on: (ByteArray new: 100).
	serializer serialize: aContext on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized context';
		nextPut: Character cr.
	file := FileSystem disk workingDirectory / (Time now yyyyMMhhmmss24 , '-' , aString) / '.zip'.
	(WriteStream on: file) nextPutAll: aStream encodedStream contents.
	file close