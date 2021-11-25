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
EDAEventSourcingEvent class >> attributesReceivedNotRequired [
	"Not need for events"
	^ Set empty
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> instVarsNeededExceptionFor: aTest [
	^ aTest eventInstVarsNeededException
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> instVarsNeededMessageFor: aTest [
	^ aTest eventInstVarsNeededMessage
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> sampleFileNameForTest: aTest [
	"overwrite if the sample file name does not follow the default criteria
	e.g. <classPrefix>EventNameUpperCamelCase -> event.name.upper.camel.case.example.json
	"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ aTest defaultSampleFileNameFor: self ]
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent class >> sampleFilesPathForTest: aTest [
	^ aTest eventSampleFilesPath
]

{ #category : #'*EDA-Domain-Tests' }
EDAEventSourcingEvent >> totallyMatches: anObject forTest: aTest [
	^ aTest event: self totallyMatchesWith: anObject
]
