Class {
	#name : #EDADefaultCommandBuilder,
	#superclass : #EDABuilder,
	#category : #'EDA-Commands-Builders'
}

{ #category : #builder }
EDADefaultCommandBuilder >> build: aClass [
	self transfomCommandJsonToParams: self params.
	^ super build: aClass
]

{ #category : #accessing }
EDADefaultCommandBuilder >> transfomCommandJsonToParams: aCommandJson [
	| meta body |
	meta := aCommandJson at: #meta ifAbsent: [ nil ].
	body := aCommandJson at: #body ifAbsent: [ nil ].	
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: EDAInvalidCommandMessage ]
		ifFalse: [
			[ 
				(meta at: #timestamp put: (DateAndTime fromString: (meta at: #timestamp) greaseString )).
				meta at: #commandId put: (meta at: #id).
				meta removeKey: #id ifAbsent: [ ].
				meta at: #originalTimestamp put: (meta at: #timestamp).
				meta removeKey: #timestamp ifAbsent: [  ].
				body at: #aggregateRootId put: (body at: #id ifAbsent: [ ]).
				body removeKey: #id ifAbsent: [  ].
				body at: #aggregateRootVersion put: (body at: #version ifAbsent: [ ]).
				body removeKey: #version ifAbsent: [  ].
				params:= (Dictionary newFrom: meta)
					addAll: body;
					yourself.

			]
			on: Exception
			do: [ :ex |
			self
					logErrorMessage:
						((WriteStream on: String new)
							nextPutAll: 'Command rejected: ';
							nextPutAll: ex greaseString;
							close;
							contents)
					andThrow: EDAInvalidCommandMessage ]
		]
]
