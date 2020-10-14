handling
writeEvent: anEvent withBasename: aBasename
	| file stderr serializer aStream result |
	stderr := Stdio stderr.
	stderr
		nextPutAll: 'Writing event ...';
		nextPut: Character cr.
	serializer := FLSerializer newDefault.
	serializer analyzer
		when: [ :o | o class isObsolete ]
		substituteBy: [ :o | nil ].
	aStream := GZipWriteStream on: (ByteArray new: 100).
	serializer serialize: anEvent on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized event';
		nextPut: Character cr.
	result := aBasename , '.event'.
	file := FileSystem disk workingDirectory / result.
	(WriteStream on: file) nextPutAll: aStream encodedStream contents.
	file close.
	^ result