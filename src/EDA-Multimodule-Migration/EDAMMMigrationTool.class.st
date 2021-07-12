Class {
	#name : #EDAMMMigrationTool,
	#superclass : #Object,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #copying }
EDAMMMigrationTool >> copySpec: aSpecDictionary from: theSourceFolderAsString to: aFolderPathAsString [
	| result command context |
	command := Dictionary new
		add: 'class' -> (aSpecDictionary at: 'input class');
		add: 'package' -> (aSpecDictionary at: 'input package');
		add: 'source root' -> theSourceFolderAsString asFileReference;
		yourself.
	context := Dictionary new.
	result := (EDAMMClassFileReaderCommandHandler new
		handleCommand: command
		within: context)
		ifTrue: [ true ]
		ifFalse: [ EDAMMClassFileWriterCommandHandler new
				handleCommand:
					(Dictionary new
						add: 'class' -> (aSpecDictionary at: 'input class');
						add:
							'target folder'
								->
									(aFolderPathAsString asFileReference
										/ (aSpecDictionary at: 'output package'));
						addAll: context;
						yourself)
				within: context ].
	^ result
]

{ #category : #api }
EDAMMMigrationTool >> processSpecsFile: aSpecsFileReference withConfigurationFile: aConfFileReference [
	| handler command |
	command := Dictionary new
		add: 'specs file' -> aSpecsFileReference;
		add: 'configuration file' -> aConfFileReference;
		yourself.
	handler := EDAMMCompositeCommandHandler
		with: EDAMMConfigurationCommandHandler new
		with:
			(EDAMMSpecIteratorCommandHandler
				for: [ :spec :cmd :ctx | 
					self
						copySpec: spec
						from: ((ctx at: 'configuration') at: 'pharo-eda')
						to: ((ctx at: 'configuration') at: (spec at: 'output module')) ]).
	handler handleCommand: command within: Dictionary new
]
