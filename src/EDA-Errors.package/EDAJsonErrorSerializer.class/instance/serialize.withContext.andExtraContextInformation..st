parsing
serialize: anError withContext: aContext andExtraContextInformation: aDictionary
	| aux body meta |
	body := Dictionary newFrom: aDictionary.
	meta := Dictionary new.
	meta at: #error put: anError description.
	meta at: #timestamp put: DateAndTime now greaseString.
	aux := Dictionary new.
	aux at: #body put: body.
	aux at: #meta put: meta.
	^ String
		streamContents: [ :stream | | writer | writer := NeoJSONWriter on: stream. self customJsonMappingsFor: writer. writer nextPut: aux ]