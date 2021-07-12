Class {
	#name : #EDAMMClassFileCatalogOverwritingCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMClassFileCatalogOverwritingCommandHandlerTest >> testClassFileCatalogOverwritingCommandHandler [
	| handler command context definitions |
	command := Dictionary new
		add: 'class' -> 'EDACommandConsumer';
		add: 'package' -> 'EDA-Messaging';
		add: 'source root' -> (FileSystem workingDirectory / 'src');
		yourself.
	context := Dictionary new.
	handler := EDAMMCompositeCommandHandler
		with: EDAMMClassFileReaderCommandHandler new
		with:
			(EDAMMClassFileCategoryOverwritingCommandHandler
				withCatalog: 'EDA-Messaging-Command-Overwritten').
	handler handleCommand: command within: context.
	self assert: (context includesKey: 'EDACommandConsumer').
	definitions := context at: 'EDACommandConsumer'.
	self assert: definitions isNotNil.
	self assert: definitions isNotEmpty.
	definitions
		select: [ :def | def isClassDefinition ]
		thenCollect:
			[ :def | self assert: def category equals: 'EDA-Messaging-Command-Overwritten' ]
]
