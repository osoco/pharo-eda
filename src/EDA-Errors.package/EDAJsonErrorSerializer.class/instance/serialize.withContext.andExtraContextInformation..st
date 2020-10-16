parsing
serialize: anException withContext: aContext andExtraContextInformation: aDictionary
	| result meta body |
	result := Dictionary new.
	meta := Dictionary new.
	meta at: #timestamp put: DateAndTime now asUTC rounded greaseString.
	meta at: #error put: anException greaseString.
	body := Dictionary newFrom: aDictionary.
	body at: #context put: aContext.
	result at: #meta put: meta.
	result at: #body put: body.
	^ String
		streamContents: [ :stream | 
			| jsonWriter |
			jsonWriter := NeoJSONWriter on: stream.
			jsonWriter
				for: DateAndTime
				customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
			self customJsonMappingsFor: jsonWriter.
			jsonWriter nextPut: result ]