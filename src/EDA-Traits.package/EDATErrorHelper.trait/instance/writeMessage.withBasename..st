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
	aStream := WriteStream on: (ByteArray new: 100).
	serializer serialize: aString on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized message';
		nextPut: Character cr.
	result := aBasename , '.message.txt'.
	file := FileSystem disk workingDirectory / result.
	file writeStream
		nextPutAll: aStream encodedStream contents; close.
	^ result