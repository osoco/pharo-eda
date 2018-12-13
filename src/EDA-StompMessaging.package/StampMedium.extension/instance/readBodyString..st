*EDA-StompMessaging
readBodyString: length
	| buffer totalRead read readStream bufferStream |
	readStream := length ifNotNil: [ ZnLimitedReadStream on: stream limit: length ] ifNil: [ stream ].
	buffer := String new: (ZnUtils streamingBufferSize min: (length ifNil: [ ZnUtils streamingBufferSize ])).
	bufferStream := nil.
	totalRead := 0.
	[ readStream atEnd ] whileFalse: [
		[ read := encoder readInto: buffer startingAt: 1 count: buffer size fromStream: readStream ]
			on: ZnByteStringBecameWideString 
			do: [ :notification | 
					buffer := notification wideString.
					bufferStream ifNotNil: [ | wideString position |
						position := bufferStream position.
						wideString := WideString from: bufferStream originalContents.
						bufferStream on: wideString; setFrom: position + 1 to: position ].
					notification resume ].
		totalRead := totalRead + read.
		totalRead > StampConstants maxBodySize
			ifTrue: [ self error: 'Body too large' ].
		bufferStream ifNil: [ 
			readStream atEnd
				ifTrue: [ self readEndFrame. ^ buffer copyFrom: 1 to: read ]
				ifFalse: [ bufferStream := (length ifNil: [ buffer species new ] ifNotNil: [ buffer species new: length ]) writeStream ] ].
		bufferStream next: read putAll: buffer startingAt: 1 ].
	self readEndFrame.
	^ bufferStream ifNil: [ String new ] ifNotNil: [ bufferStream contents ]