Class {
	#name : #EDAMMClassFileReaderCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMClassFileReaderCommandHandlerTest >> testClassFileReaderCommandHandler [
	| handler command context definitions |
	command := Dictionary new
		add: 'class' -> 'EDACommandConsumer';
		add: 'package' -> 'EDA-Messaging';
		add: 'source root' -> (FileSystem workingDirectory / 'src');
		yourself.
	context := Dictionary new.
	handler := EDAMMClassFileReaderCommandHandler new.
	handler handleCommand: command within: context.
	self assert: (context includesKey: 'EDACommandConsumer').
	definitions := context at: 'EDACommandConsumer'.
	self assert: definitions isNotNil.
	self assert: definitions isNotEmpty.
	definitions
		do: [ :def | self assert: def className equals: 'EDACommandConsumer' ]
]
