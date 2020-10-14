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
	aStream := WriteStream on: (ByteArray new: 100).
	serializer serialize: anEvent on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized event';
		nextPut: Character cr.
	result := aBasename , '.event.txt'.
	file := FileSystem disk workingDirectory / result.
	file writeStream nextPutAll: aStream encodedStream contents; close.
	^ result