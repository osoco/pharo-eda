Class {
	#name : #EDAMMClassFileReaderCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'command handling' }
EDAMMClassFileReaderCommandHandler >> handleCommand: aCommand within: aContext [
	| result |
	result := false.
	(self inputValid: aCommand)
		ifTrue: [ | sourceRoot packageName className entries |
			sourceRoot := aCommand at: 'source root'.
			packageName := aCommand at: 'package'.
			className := aCommand at: 'class'.
			entries := EDAMMClassFile new
				readClassNamed: className
				inPackage: packageName
				inFolder: sourceRoot.
			entries
				ifEmpty: [ result := true ]
				ifNotEmpty: [ aContext at: className put: entries ] ].
	^ result
]

{ #category : #'command handling' }
EDAMMClassFileReaderCommandHandler >> inputValid: aCommand [
	^ (aCommand includesKey: 'source root')
		and: [ (aCommand
				includesKey: 'package')
				and: [ aCommand includesKey: 'class' ] ]
]
