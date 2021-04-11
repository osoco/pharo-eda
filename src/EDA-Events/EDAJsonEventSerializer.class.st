Class {
	#name : #EDAJsonEventSerializer,
	#superclass : #EDAMessageSerializer,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'writer',
		'errorWriter'
	],
	#category : #'EDA-Events-Serializers'
}

{ #category : #converting }
EDAJsonEventSerializer class >> asEventName: event [
	| words |
	words :=
		event delete ifTrue: [
			| aggregateRootName |
			aggregateRootName := (EDAMessageSerializer nameWithoutPrefixForMessageClass: event aggregateRootClass) asUppercase.
			OrderedCollection with: aggregateRootName with: 'DELETED'
		] ifFalse: [
			(EDAMessageSerializer nameWithoutPrefixForMessageClass: event class)
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
	| result |
	result := Dictionary new.
	result add: 'id' -> UUID new greaseString;
	
	add:		('version' -> anEvent version);
add:			('timestamp' -> DateAndTime now asUTC rounded);
add: 			('correlationId' -> anEvent correlationId);
add: 			('type' -> (self class asEventName: anEvent));
add:			('delete' -> anEvent delete).
			^ result
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
	aux at: #name put: (EDAMessageSerializer nameWithoutPrefixForMessageClass: error).
	paramsDict := Dictionary
		newFrom:
			{('error' -> true).
			('description' -> error description)}.
	aux at: #params put: paramsDict.
	^ String streamContents: [ :stream | (NeoJSONWriter on: stream) nextPut: aux ]
]