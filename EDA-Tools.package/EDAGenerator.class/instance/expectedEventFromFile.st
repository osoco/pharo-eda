code generation
expectedEventFromFile
	| evtJson id body |
	evtJson := NeoJSONReader fromString: self readEventExampleFile.
	body := evtJson at: #body.
	id := body at: #id ifAbsent: [ nil ].
	body at: #id put: '<ANYTHING>'.
	self retrieveAggregateIdNames
		do: [ :aux | 
			| var |
			var := body at: aux asSymbol ifAbsent: [ nil ].
			var ifNotNil: [ body at: aux asSymbol put: '<ANYTHING>' ] ].
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime customDo: [ :mapping | mapping encoder: [ :dateAndTime | '<ANYTHING>' ] ];
				nextPut: evtJson ]