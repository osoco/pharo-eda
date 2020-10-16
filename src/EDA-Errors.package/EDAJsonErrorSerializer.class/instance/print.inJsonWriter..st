customization
print: anObject inJsonWriter: aJsonWriter
	aJsonWriter
		for: anObject
		customDo: [ :mapping |
			mapping
				encoder: [ :obj |
					| stream |
					stream := WriteStream on: String new.
					obj printOn: stream.
					stream contents ] ]