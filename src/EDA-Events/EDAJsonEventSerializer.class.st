Class {
	#name : #EDAJsonEventSerializer,
	#superclass : #EDACMessageSerializer,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#instVars : [
		'writer',
		'errorWriter'
	],
	#category : #'EDA-Events'
}

{ #category : #converting }
EDAJsonEventSerializer class >> asEventName: event [
	| words |
	words :=
		event delete ifTrue: [
			| aggregateRootName |
			aggregateRootName := (self nameWithoutPrefixForMessageClass: event aggregateRootClass) asUppercase.
			OrderedCollection with: aggregateRootName with: 'DELETED'
		] ifFalse: [
			(self nameWithoutPrefixForMessageClass: event class)
				regex: '[A-Z][a-z0-9]+' matchesCollect: [ :word | word greaseString asUppercase ].
		].
	^ String streamContents: [ :stream | words asStringOn: stream delimiter: '_' ]

]

{ #category : #initialization }
EDAJsonEventSerializer >> buildBodySectionForEvent: anEvent [
	^ Dictionary newFrom:
		(anEvent class allInstVarNames \ {#aggregateRootClass . #timestamp . #commandId . #version}
			collect: [ :var | var -> (anEvent instVarNamed: var) ])
]

{ #category : #initialization }
EDAJsonEventSerializer >> buildMetaSectionForEvent: anEvent [
	^ Dictionary
		newFrom:
			{('id' -> UUID new greaseString).
			('version' -> anEvent version).
			('timestamp' -> DateAndTime now asUTC rounded).
			('correlationId' -> anEvent commandId).
			('type' -> (self class asEventName: anEvent)).
			('delete' -> (anEvent delete))}

]

{ #category : #accessing }
EDAJsonEventSerializer >> customJsonMappingsFor: jsonWriter [

]

{ #category : #parsing }
EDAJsonEventSerializer >> serialize: anEvent [
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
]

{ #category : #writing }
EDAJsonEventSerializer >> writeError: error [ 
	| aux paramsDict |
	aux := Dictionary new.
	aux at: #name put: (self class nameWithoutPrefixForMessageClass: error).
	paramsDict := Dictionary
		newFrom:
			{('error' -> true).
			('description' -> error description)}.
	aux at: #params put: paramsDict.
	^ String streamContents: [ :stream | (NeoJSONWriter on: stream) nextPut: aux ]
]
