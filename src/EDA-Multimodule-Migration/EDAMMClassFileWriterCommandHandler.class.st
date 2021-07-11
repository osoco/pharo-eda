Class {
	#name : #EDAMMClassFileWriterCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'command handling' }
EDAMMClassFileWriterCommandHandler >> handleCommand: aCommand within: aContext [
	| result |
	result := false.
	(self inputValid: aCommand)
		ifTrue: [ | className |
			className := aCommand at: 'class'.
			EDAMMClassFile new
				writeClassNamed: className
				withDefinitions: (aCommand at: className)
				inFolder: (aCommand at: 'target folder') ].
	^ result
]

{ #category : #'command handling' }
EDAMMClassFileWriterCommandHandler >> inputValid: aCommand [
	^ (aCommand includesKey: 'target folder')
		and: [ aCommand includesKey: 'class' ]
]
