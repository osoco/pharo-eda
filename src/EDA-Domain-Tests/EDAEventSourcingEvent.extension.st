Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent >> asJsonMessage [
	^ (self class testMessageClass fromInstance: self) asJsonMessage
]

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
EDAEventSourcingEvent class >> attributesReceivedNotRequired [
	"Not need for events"
	^ Set empty
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> sampleFileNameForTestMessage: aTestMessage [
	"overwrite if the sample file name does not follow the default criteria
	e.g. <classPrefix>EventNameUpperCamelCase -> event.name.upper.camel.case.example.json
	Take care set your domain test package as method category extension
	"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ aTestMessage defaultSampleFileNameFor: self ]
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> sampleFilesPathForTestMessage: aTestMessage [
	^ aTestMessage eventSampleFilesPath
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> testMessageClass [
	^ EDATestEventMessage
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent >> totallyMatches: anObject forTest: aTest [
	^ aTest event: self totallyMatchesWith: anObject
]
