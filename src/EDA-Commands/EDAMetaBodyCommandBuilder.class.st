Class {
	#name : #EDAMetaBodyCommandBuilder,
	#superclass : #EDACommandBuilder,
	#traits : 'EDATMetaBodyTypeHelper',
	#classTraits : 'EDATMetaBodyTypeHelper classTrait',
	#instVars : [
		'metaBodyParams'
	],
	#category : #'EDA-Commands-Builders'
}

{ #category : #accessing }
EDAMetaBodyCommandBuilder class >> priority [
	^ 50
]

{ #category : #accessing }
EDAMetaBodyCommandBuilder >> metaBodyParams [
	^ metaBodyParams
		ifNil: [ self metaBodyParams: self params copy.
			self params: (self transformCommandJsonToParams: self metaBodyParams).
			metaBodyParams ]
]

{ #category : #accessing }
EDAMetaBodyCommandBuilder >> metaBodyParams: anObject [
	metaBodyParams := anObject
]

{ #category : #testing }
EDAMetaBodyCommandBuilder >> retrieveType [
	^ self retrieveType: self metaBodyParams
]

{ #category : #accessing }
EDAMetaBodyCommandBuilder >> transformCommandJsonToParams: unprocessedParams [
	| meta body |
	meta := unprocessedParams at: #meta ifAbsent: [ nil ].
	body := unprocessedParams at: #body ifAbsent: [ nil ].
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: self errorClass ]
		ifFalse: [ [ meta
				at: #timestamp
				put:
					(meta
						at: #timestamp
						ifPresent: [ :v | DateAndTime fromString: v ]
						ifAbsent: [ DateAndTime now ]).
			meta at: #id ifPresent: [ :v | meta at: #commandId put: v ].
			meta removeKey: #id ifAbsent: [ ].
			meta at: #originalTimestamp put: (meta at: #timestamp).
			meta removeKey: #timestamp ifAbsent: [  ].
			body at: #aggregateRootId put: (body at: #id ifAbsent: [ ]).
			body removeKey: #id ifAbsent: [ ].
			body
				at: #aggregateRootVersion
				put: (body at: #version ifAbsent: [ ]).
			body removeKey: #version ifAbsent: [ ].
			^ (Dictionary newFrom: meta)
				addAll: body;
				yourself ]
				on: Exception
				do: [ :ex | 
					self
						logErrorMessage:
							((WriteStream on: String new)
								nextPutAll: 'Command rejected: ';
								nextPutAll: ex greaseString;
								close;
								contents)
						andThrow: self errorClass ] ]
]
