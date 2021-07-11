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
			fileReference := aCommand at: 'specs file'.
			aContext
				at: 'specs'
				put: (EDAMMSpecFile new readFile: fileReference) ]
		ifFalse: [ result := true ].
	^ result
]

{ #category : #'command checking' }
EDAMMSpecReaderCommandHandler >> inputValid: aCommand [
	^ aCommand includesKey: 'specs file'
]
