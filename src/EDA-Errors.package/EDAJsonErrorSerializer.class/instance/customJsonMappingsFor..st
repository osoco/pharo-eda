accessing
customJsonMappingsFor: jsonWriter
	jsonWriter
		for: Context
		customDo: [ :mapping |
			mapping
				encoder: [ :objectToEncode |
					| contextDict |
					contextDict := Dictionary new.
					contextDict at: #stack put: (objectToEncode stack copyFrom: 1 to: 5).
					contextDict ] ]