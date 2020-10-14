parsing
customJsonMappingsFor: jsonWriter
	jsonWriter
		for: Context
		customDo: [ :mapping | 
			mapping
				encoder: [ :ctx | 
					| contextDict stream |
					contextDict := Dictionary new.
					stream := WriteStream on: String new.
					context stack printOn: stream.
					contextDict at: #context put: stream contents.
					contextDict ] ]