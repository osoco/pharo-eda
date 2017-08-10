initialization
initializeWriter
	writer := [ :event | 
		| eventDict meta body dateCreated |
		eventDict := Dictionary new.
		meta := self buildMetaSectionForEvent: event.
		eventDict at: #meta put: meta.
		body := self buildBodySectionForEvent: event.
		body at: #version put: event aggregateRootVersion.
		dateCreated := event timestamp.
		dateCreated isString ifFalse: [ dateCreated := dateCreated asUTC rounded ].
		body at: #dateCreated put: dateCreated.
		eventDict at: #body put: body.
		String
			streamContents: [ :stream | 
				| jsonWriter |
				jsonWriter := NeoJSONWriter on: stream.
				jsonWriter
					for: DateAndTime customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
				self customJsonMappingsFor: jsonWriter.
				jsonWriter nextPut: eventDict
			]
	]