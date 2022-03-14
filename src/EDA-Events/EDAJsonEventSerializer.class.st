Class {
	#name : #EDAJsonEventSerializer,
	#superclass : #EDAMessageSerializer,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'writer',
		'errorWriter'
	],
	#category : #'EDA-Events-Serializers'
}

{ #category : #converting }
EDAJsonEventSerializer class >> asEventName: event [
	| type words |
	type :=
		event delete
			ifTrue: [
				| aggregateRootName |
				aggregateRootName := (EDAMessageSerializer nameWithoutPrefixForMessageClass: event aggregateRootClass) , 'Deleted' ]
			ifFalse: [
				(EDAMessageSerializer nameWithoutPrefixForMessageClass: event class) ].
	words := type regex: '[A-Z][a-z0-9]+' matchesCollect: [ :word | word greaseString asUppercase ].
	^ String streamContents: [ :stream | words asStringOn: stream delimiter: '_' ]

]

{ #category : #initialization }
EDAJsonEventSerializer class >> buildBodySectionForEvent: anEvent [
	| bodyDict |
	bodyDict := Dictionary newFrom:
		(anEvent class allInstVarNames \ anEvent class publishableMetaAttributes \anEvent class nonPublishableBodyAttributes
			collect: [ :var | var -> (anEvent instVarNamed: var) ]).
	bodyDict at: #dateCreated ifPresent: [ :dc |
		| formattedDateCreated |
		(dc isKindOf: DateAndTime)
			ifTrue: [ 
				formattedDateCreated := dc asUTC rounded.
				bodyDict at: #dateCreated put: formattedDateCreated ] ].
	(self domainToMessageAttributesMap at: #body)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			bodyDict changeKey: domainAttributeName to: messageAttributeName
			 ].
	^ bodyDict
]

{ #category : #parsing }
EDAJsonEventSerializer class >> buildMessageFormatDictForEvent: anEvent [ 
	| eventDict meta body |
	eventDict := Dictionary new.
	meta := self buildMetaSectionForEvent: anEvent.
	eventDict at: #meta put: meta.
	body := self buildBodySectionForEvent: anEvent.
	eventDict at: #body put: body.
	^ eventDict
]

{ #category : #initialization }
EDAJsonEventSerializer class >> buildMetaSectionForEvent: anEvent [
	| metaJsonDict |
	metaJsonDict := Dictionary
		with: 'messageId' -> UUID new greaseString
		with: 'version' -> anEvent version
		with: 'timestamp' -> DateAndTime now asUTC rounded
		with: 'commandId' -> anEvent commandId
		with: 'type' -> (self asEventName: anEvent).
	(self domainToMessageAttributesMap at: #meta)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			metaJsonDict changeKey: domainAttributeName to: messageAttributeName
			 ].
	^ metaJsonDict
]

{ #category : #converting }
EDAJsonEventSerializer class >> domainToMessageAttributesMap [
	^ Dictionary
		with:
			#meta -> (Dictionary
				with: #messageId -> #id 
				with: #commandId -> #correlationId)
		with:
			#body -> (Dictionary 
				with: #aggregateRootVersion -> #version)
	
]

{ #category : #accessing }
EDAJsonEventSerializer >> customJsonMappingsFor: jsonWriter [

]

{ #category : #parsing }
EDAJsonEventSerializer >> serialize: anEvent [
	| eventDict |
	eventDict := self class buildMessageFormatDictForEvent: anEvent.
	^ String
		streamContents: [ :stream |
			| jsonWriter |
			jsonWriter := NeoJSONWriter on: stream.
			jsonWriter
				for: DateAndTime
				customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
			self customJsonMappingsFor: jsonWriter.
			jsonWriter prettyPrint: true.
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
