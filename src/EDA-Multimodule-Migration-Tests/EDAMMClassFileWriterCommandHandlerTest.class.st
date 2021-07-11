Class {
	#name : #EDAMMClassFileWriterCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMClassFileWriterCommandHandlerTest >> testClassFileWriterCommandHandler [
	| handler command context targetFolder outputFile |
	targetFolder := FileSystem workingDirectory / 'tests'.
	outputFile := (targetFolder / 'EDACommandConsumer.st').
	outputFile exists ifTrue: [ outputFile delete ].
	command := Dictionary new
		add: 'class' -> 'EDACommandConsumer';
		add:
			'EDACommandConsumer'
				->
					(EDAMMClassFile new
						readClassNamed: 'EDACommandConsumer'
						inPackage: 'EDA-Messaging'
						inFolder: FileSystem workingDirectory / 'src');
		add: 'target folder' -> targetFolder;
		yourself.
	context := Dictionary new.
	handler := EDAMMClassFileWriterCommandHandler new.
	handler handleCommand: command within: context.
	self assert: outputFile exists
]
