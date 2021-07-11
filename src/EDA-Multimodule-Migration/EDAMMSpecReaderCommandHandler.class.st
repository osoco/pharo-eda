Class {
	#name : #EDAMMSpecReaderCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'command handling' }
EDAMMSpecReaderCommandHandler >> handleCommand: aCommand within: aContext [
	| result |
	result := false.
	(self inputValid: aCommand)
		ifTrue: [ | fileReference |
			fileReference := aCommand at: 'spec file'.
			aContext
				at: 'spec'
				put: (EDAMMSpecFile new readFile: fileReference) ]
		ifFalse: [ result := true ].
	^ result
]

{ #category : #'command checking' }
EDAMMSpecReaderCommandHandler >> inputValid: aCommand [
	^ aCommand includesKey: 'spec file'
]
