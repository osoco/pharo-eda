Class {
	#name : #EDAJsonErrorSerializer,
	#superclass : #EDAMessageSerializer,
	#instVars : [
		'context',
		'extraContextInformation'
	],
	#category : 'EDA-Errors-Strategies'
}

{ #category : #'instance creation' }
EDAJsonErrorSerializer class >> withContext: aContext andExtraContextInformation: aDictionary [
	^ self new context: aContext; extraContextInformation: aDictionary; yourself
]

{ #category : #accessing }
EDAJsonErrorSerializer >> context [
	^ context
]

{ #category : #accessing }
EDAJsonErrorSerializer >> context: aContext [
	context := aContext
]

{ #category : #customization }
EDAJsonErrorSerializer >> customJsonMappingsFor: aJsonWriter [
	self print: Context inJsonWriter: aJsonWriter.
	EDADomainException
		allSubclassesDo: [ :cls | self printException: cls inJsonWriter: aJsonWriter ].
	EDACommand
		allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].
	EDAEventSourcingEvent
		allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].
		EDAAggregateRoot
				allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].

]

{ #category : #accessing }
EDAJsonErrorSerializer >> extraContextInformation [
	^ extraContextInformation
]

{ #category : #accessing }
EDAJsonErrorSerializer >> extraContextInformation: aDictionary [
	extraContextInformation := aDictionary
]

{ #category : #customization }
EDAJsonErrorSerializer >> print: anObject inJsonWriter: aJsonWriter [
	aJsonWriter
		for: anObject
		customDo: [ :mapping |
			mapping
				encoder: [ :obj |
					| stream |
					stream := WriteStream on: String new.
					obj printOn: stream.
					stream contents ] ]
]

{ #category : #customization }
EDAJsonErrorSerializer >> printException: anExceptionClass inJsonWriter: aJsonWriter [
	aJsonWriter
		for: anExceptionClass
		customDo: [ :mapping |
			mapping
				encoder: [ :cls |
					| stream |
					stream := WriteStream on: String new.
					cls description greaseString printOn: stream.
					stream contents ] ]

]

{ #category : #parsing }
EDAJsonErrorSerializer >> serialize: anException [
	^ self serialize: anException withContext: self context andExtraContextInformation: self extraContextInformation
]

{ #category : #parsing }
EDAJsonErrorSerializer >> serialize: anException withContext: aContext andExtraContextInformation: aDictionary [
	| result meta body |
	result := Dictionary new.
	meta := Dictionary new.
	meta at: #timestamp put: DateAndTime now asUTC rounded greaseString.
	meta at: #error put: anException greaseString.
	body := Dictionary newFrom: aDictionary.
	body at: #context put: aContext.
	result at: #meta put: meta.
	result at: #body put: body.
	^ String
		streamContents: [ :stream |
			| jsonWriter |
			jsonWriter := NeoJSONWriter on: stream.
			jsonWriter
				for: DateAndTime
				customDo: [ :mapping | mapping encoder: [ :tmst | tmst printString ] ].
			self customJsonMappingsFor: jsonWriter.
			jsonWriter nextPut: result ]
]
