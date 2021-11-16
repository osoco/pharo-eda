Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent >> asJsonString [	
	| evtDict |
	evtDict := self asDictionary.
	^ String streamContents: [ :s |
		| jsonWriter |
		jsonWriter := NeoJSONWriter on: s.
		jsonWriter prettyPrint: true.
		jsonWriter
			for: DateAndTime
			customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
		"self customJsonMappingsFor: jsonWriter."
		jsonWriter nextPut: evtDict ]
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent >> totallyMatches: anObject forTest: aTest [
	^ aTest event: self totallyMatchesWith: anObject
]
