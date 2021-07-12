Class {
	#name : #EDAMMMigrationToolTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #helpers }
EDAMMMigrationToolTest >> deleteFolder: aFolder [
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
EDAMMMigrationToolTest >> testMigrationTool [
	| outputFolder confFile specFile classReader definitions classDefinition |
	outputFolder := FileSystem root / 'tmp' / 'pharo-eda-api' / 'src'.
	self deleteFolder: outputFolder.
	outputFolder ensureCreateDirectory.
	confFile := FileSystem workingDirectory / 'tests'
		/ 'EDAMMMigrationTool_testMigrationTool.config.csv'.
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
				nextPutAll: 'EDAAPI-Events-Events';
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
				nextPutAll: 'EDAAPI-Aggregates';
				nextPut: $,;
				nextPutAll: 'EDAAggregateRoot';
				nextPut: Character cr;
				nextPut: Character lf ].
	EDAMMMigrationTool new
		processSpecsFile: specFile
		withConfigurationFile: confFile.
	classReader := EDAMMClassFile new.
	self assert: (outputFolder / 'EDAAPI-Events') exists.
	self
		assert: (outputFolder / 'EDAAPI-Events' / 'EDAEventSourcingEvent.st') exists.
	definitions := classReader
		readClassNamed: 'EDAEventSourcingEvent'
		inPackage: 'EDAAPI-Events'
		inFolder: outputFolder.
	self
		assert: (definitions select: [ :def | def isClassDefinition ]) isNotEmpty.
	classDefinition := (definitions
		select: [ :def | def isClassDefinition ]) first.
	self assert: classDefinition isNotNil.
	self assert: classDefinition category equals: 'EDAAPI-Events-Events'.
	self assert: (outputFolder / 'EDAAPI-Aggregates') exists.
	self
		assert: (outputFolder / 'EDAAPI-Aggregates' / 'EDAAggregateRoot.st') exists.
	definitions := classReader
		readClassNamed: 'EDAAggregateRoot'
		inPackage: 'EDAAPI-Aggregates'
		inFolder: outputFolder.
	self
		assert: (definitions select: [ :def | def isClassDefinition ]) isNotEmpty.
	classDefinition := (definitions
		select: [ :def | def isClassDefinition ]) first.
	self assert: classDefinition isNotNil.
	self assert: classDefinition category equals: 'EDAAPI-Aggregates'
]
