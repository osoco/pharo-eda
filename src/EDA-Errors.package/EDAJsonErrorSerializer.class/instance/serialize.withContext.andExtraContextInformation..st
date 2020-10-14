parsing
serialize: anError withContext: aContext andExtraContextInformation: aDictionary
	| aux paramsDict body |
	paramsDict := Dictionary new.
	paramsDict at: #error put: true.
	paramsDict at: #description put: anError description.
	aux := Dictionary new.
	aux at: #meta put: paramsDict.
	body := Dictionary newFrom: aDictionary.
	body at: #context put: aContext.
	aux at: #body put: body.
	^ String
		streamContents: [ :stream |
						| jsonWriter |
			jsonWriter := NeoJSONWriter on: stream.
			jsonWriter
				for: DateAndTime
				customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
			self customJsonMappingsFor: jsonWriter.
			jsonWriter nextPut: aux ]