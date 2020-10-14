customization
customJsonMappingsFor: aJsonWriter
	aJsonWriter
		for: Context
		customDo: [ :mapping |
			mapping
				encoder: [ :ctx |
					| stream |
					stream := WriteStream on: String new.
					ctx printOn: stream.
					stream contents ] ]