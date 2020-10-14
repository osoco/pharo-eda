parsing
serialize: anEvent
	| eventDict meta body dateCreated |
	eventDict := Dictionary new.
	meta := self buildMetaSectionForEvent: anEvent.
	eventDict at: #meta put: meta.
	body := self buildBodySectionForEvent: anEvent.
	body at: #version put: anEvent aggregateRootVersion.
	dateCreated := anEvent timestamp.
	dateCreated isString
		ifFalse: [ dateCreated := dateCreated asUTC rounded ].
	body at: #dateCreated put: dateCreated.
	eventDict at: #body put: body.
	^ String
		streamContents: [ :stream | 
			| jsonWriter |
			jsonWriter := NeoJSONWriter on: stream.
			jsonWriter
				for: DateAndTime
				customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
			self customJsonMappingsFor: jsonWriter.
			jsonWriter nextPut: eventDict ]