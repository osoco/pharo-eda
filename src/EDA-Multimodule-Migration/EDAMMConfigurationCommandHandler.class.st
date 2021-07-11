Class {
	#name : #EDAMMConfigurationCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'command handling' }
EDAMMConfigurationCommandHandler >> handleCommand: aCommand within: aContext [
	| result |
	result := false.
	(self inputValid: aCommand)
		ifTrue: [ | fileReference |
			fileReference := aCommand at: 'configuration file'.
			aContext
				at: 'configuration'
				put: (EDAMMModuleFile new readFile: fileReference) ]
		ifFalse: [ result := true ].
	^ result
]

{ #category : #'command handling' }
EDAMMConfigurationCommandHandler >> inputValid: aCommand [
	^ aCommand includesKey: 'configuration file'
]
