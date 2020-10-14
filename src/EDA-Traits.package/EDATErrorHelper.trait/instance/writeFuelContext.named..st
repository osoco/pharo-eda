handling
writeFuelContext: aContext named: aString
	| file stderr serializer aStream result |
	stderr := Stdio stderr.
	stderr nextPut: Character cr.
"	serializer := FLSerializer newDefault.
	serializer analyzer
		when: [ :o | o class isObsolete ]
		substituteBy: [ :o | nil ].
	aStream := GZipWriteStream on: (ByteArray new: 100).
	serializer serialize: aContext on: aStream.
	aStream close.
	stderr
		nextPutAll: 'Serialized context';
		nextPut: Character cr.
"	result := Time now yyyyMMhhmmss24 , '-' , aString.
"	file := FileSystem disk workingDirectory / (result , '.zip').
	(WriteStream on: file) nextPutAll: aStream encodedStream contents.
	file close."
	^ result