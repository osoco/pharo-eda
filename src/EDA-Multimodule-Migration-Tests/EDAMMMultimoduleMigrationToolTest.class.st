Class {
	#name : #EDAMMMultimoduleMigrationToolTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #helpers }
EDAMMMultimoduleMigrationToolTest >> deleteFolder: aFolder [
	aFolder exists
		ifFalse: [ ^ self ].
	aFolder asFileReference entries
		do: [ :f | 
			f isDirectory
				ifTrue: [ self deleteFolder: f ]
				ifFalse: [ f reference delete ] ].
	aFolder asFileReference delete
]

{ #category : #tests }
EDAMMMultimoduleMigrationToolTest >> testMultimoduleTool [
	| outputFolder confFile specFile |
	outputFolder := FileSystem root / 'tmp' / 'pharo-eda-api' / 'src'.
	self deleteFolder: outputFolder.
	outputFolder ensureCreateDirectory.
	confFile := FileSystem workingDirectory / 'tests'
		/ 'EDAMMMultimoduleTool_testMultimoduleTool.config.csv'.
	confFile exists
		ifTrue: [ confFile delete ].
	confFile asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: 'pharo-eda';
				nextPut: $,;
				nextPutAll: (FileSystem workingDirectory / 'src') path pathString;
				nextPut: Character cr;
				nextPut: Character lf;
				nextPutAll: 'pharo-eda-api';
				nextPut: $,;
				nextPutAll: outputFolder path pathString;
				nextPut: Character cr;
				nextPut: Character lf ].
	specFile := FileSystem workingDirectory / 'tests'
		/ 'testMultimoduleTool.spec.csv'.
	specFile asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: 'pharo-eda';
				nextPut: $,;
				nextPutAll: 'EDA-Events';
				nextPut: $,;
				nextPutAll: 'EDAEventSourcingEvent';
				nextPut: $,;
				nextPutAll: 'pharo-eda-api';
				nextPut: $,;
				nextPutAll: 'EDAAPI-Events';
				nextPut: $,;
				nextPutAll: 'EDAEventSourcingEvent';
				nextPut: Character cr;
				nextPut: Character lf;
				nextPutAll: 'pharo-eda';
				nextPut: $,;
				nextPutAll: 'EDA-Domain';
				nextPut: $,;
				nextPutAll: 'EDAAggregateRoot';
				nextPut: $,;
				nextPutAll: 'pharo-eda-api';
				nextPut: $,;
				nextPutAll: 'EDAAPI-Aggregates';
				nextPut: $,;
				nextPutAll: 'EDAAggregateRoot';
				nextPut: Character cr;
				nextPut: Character lf ].
	EDAMMMultimoduleTool new
		processSpecsFile: specFile
		withConfigurationFile: confFile.
	self assert: (outputFolder / 'EDAAPI-Events') exists.
	self
		assert: (outputFolder / 'EDAAPI-Events' / 'EDAEventSourcingEvent.st') exists.
	self assert: (outputFolder / 'EDAAPI-Aggregates') exists.
	self
		assert: (outputFolder / 'EDAAPI-Aggregates' / 'EDAAggregateRoot.st') exists
]
