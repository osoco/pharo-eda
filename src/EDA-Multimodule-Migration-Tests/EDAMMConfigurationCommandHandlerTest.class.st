Class {
	#name : #EDAMMConfigurationCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMConfigurationCommandHandlerTest >> testConfigurationCommandHandler [
	| handler command context file entries |
	file := FileSystem workingDirectory / 'tests' / 'modules1.csv'.
	file asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: 'module1';
				nextPut: $,;
				nextPutAll: '/tmp/module1/src';
				nextPut: Character cr;
				nextPut: Character lf ].
	context := Dictionary new.
	command := Dictionary new.
	command add: 'configuration file' -> file.
	handler := EDAMMConfigurationCommandHandler new.
	handler handleCommand: command within: context.
	self assert: (context includesKey: 'configuration').
	entries := context at: 'configuration'.
	self assert: entries isNotNil.
	self assert: (entries includesKey: 'module1').
	self assert: (entries at: 'module1') equals: '/tmp/module1/src'
]
