customization
printException: anExceptionClass inJsonWriter: aJsonWriter
	aJsonWriter
		for: anExceptionClass
		customDo: [ :mapping | 
			mapping
				encoder: [ :cls | 
					| stream |
					stream := WriteStream on: String new.
					cls description greaseString printOn: stream.
					stream contents ] ]
