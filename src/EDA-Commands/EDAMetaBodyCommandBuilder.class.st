Class {
	#name : #EDAMetaBodyCommandBuilder,
	#superclass : #EDACommandBuilder,
	#traits : 'EDATMetaBodyTypeHelper',
	#classTraits : 'EDATMetaBodyTypeHelper classTrait',
	#category : #'EDA-Commands-Builders'
}

{ #category : #builder }
EDAMetaBodyCommandBuilder >> build [
	self params: (self transfomCommandJsonToParams: self params).
	^ super build
]

{ #category : #accessing }
EDAMetaBodyCommandBuilder >> transfomCommandJsonToParams: unprocessedParams [
	| meta body |
	meta := unprocessedParams at: #meta ifAbsent: [ nil ].
	body := unprocessedParams at: #body ifAbsent: [ nil ].
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: self errorClass ]
		ifFalse: [ [ meta
				at: #timestamp
				put: (DateAndTime fromString: (meta at: #timestamp) greaseString).
			meta at: #commandId put: (meta at: #id).
			meta removeKey: #id ifAbsent: [  ].
			meta at: #originalTimestamp put: (meta at: #timestamp).
			meta removeKey: #timestamp ifAbsent: [  ].
			body at: #aggregateRootId put: (body at: #id ifAbsent: [  ]).
			body removeKey: #id ifAbsent: [  ].
			body
				at: #aggregateRootVersion
				put: (body at: #version ifAbsent: [  ]).
			body removeKey: #version ifAbsent: [  ].
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
