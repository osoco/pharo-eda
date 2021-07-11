Class {
	#name : #EDAMMSpecReaderCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMSpecReaderCommandHandlerTest >> testSpecReaderCommandHandler [
	| handler command context file entries |
	file := FileSystem workingDirectory / 'tests' / 'spec1.csv'.
	file asFileReference
		writeStreamDo: [ :stream | 
			stream
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
				nextPut: Character lf ].
	context := Dictionary new.
	command := Dictionary new
		add: 'spec file' -> file;
		yourself.
	handler := EDAMMSpecReaderCommandHandler new.
	handler handleCommand: command within: context.
	self assert: (context includesKey: 'spec').
	entries := context at: 'spec'.
	self assert: entries isNotNil.
	self assert: (entries first includesKey: 'input package').
	self assert: (entries first at: 'input package') equals: 'EDA-Events'.
	self assert: (entries first includesKey: 'input class').
	self
		assert: (entries first at: 'input class')
		equals: 'EDAEventSourcingEvent'.
	self assert: (entries first includesKey: 'output module').
	self
		assert: (entries first at: 'output module')
		equals: 'pharo-eda-api'.
	self assert: (entries first includesKey: 'output package').
	self
		assert: (entries first at: 'output package')
		equals: 'EDAAPI-Events'.
	self assert: (entries first includesKey: 'output class').
	self
		assert: (entries first at: 'output class')
		equals: 'EDAEventSourcingEvent'
]
