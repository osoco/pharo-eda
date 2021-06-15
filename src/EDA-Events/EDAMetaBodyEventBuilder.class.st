Class {
	#name : #EDAMetaBodyEventBuilder,
	#superclass : #EDABuilder,
	#traits : 'EDATEventBuilder + EDATMetaBodyTypeHelper + EDATPragmaBasedMessageBuilder',
	#classTraits : 'EDATEventBuilder classTrait + EDATMetaBodyTypeHelper classTrait + EDATPragmaBasedMessageBuilder classTrait',
	#category : #'EDA-Events-Builders'
}

{ #category : #meta }
EDAMetaBodyEventBuilder class >> pragmaSymbol [
	^ #eventName:
]

{ #category : #accessing }
EDAMetaBodyEventBuilder >> metaBodyParams [
	^ metaBodyParams
		ifNil: [ self metaBodyParams: self params copy.
			self params: (self transformEventJsonToParams: self metaBodyParams).
			metaBodyParams ]
]

{ #category : #accessing }
EDAMetaBodyEventBuilder >> metaBodyParams: anObject [
	metaBodyParams := anObject
]

{ #category : #testing }
EDAMetaBodyEventBuilder >> retrieveType [
	^ self retrieveType: self metaBodyParams
]

{ #category : #'as yet unclassified' }
EDAMetaBodyEventBuilder >> transformEventJsonToParams: aCommandJson [
	| meta body |
	meta := aCommandJson at: #meta ifAbsent: [ nil ].
	body := aCommandJson at: #body ifAbsent: [ nil ].
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: EDAInvalidEventMessage ]
		ifFalse: [ [
			meta
				at: #timestamp
				put:
					(meta
						at: #timestamp
						ifPresent: [ :v | DateAndTime fromString: v ]
						ifAbsent: [ DateAndTime now ]).
			meta at: #correlationId ifPresent: [ :v | meta at: #commandId put: v ].
			meta removeKey: #correlationId ifAbsent: [ ].
			body at: #version ifPresent: [ :v | body at: #aggregateRootVersion put: v ].
			body removeKey: #version ifAbsent: [ ].
			body at: #dateCreated ifPresent: [ :v | body at: #timestamp put: v ].
			body removeKey: #dateCreated ifAbsent: [ ].
			^ (Dictionary newFrom: meta)
				addAll: body;
				yourself ]
				on: Exception
				do: [ :ex | 
					self
						logErrorMessage:
							((WriteStream on: String new)
								nextPutAll: 'Event rejected: ';
								nextPutAll: ex greaseString;
								close;
								contents)
						andThrow: self errorClass ] ]
]
