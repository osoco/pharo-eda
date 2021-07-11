Class {
	#name : #EDAMMCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMCommandHandlerTest >> testCompositeCommandHandler [
	| handler |
	handler := EDAMMCompositeCommandHandler
		with: EDAMMDummyCommandHandler new
		with: (EDAMMLoggingCommandHandler on: (WriteStream on: String new)).
	self assert: (handler handleCommand: nil within: nil)
]

{ #category : #tests }
EDAMMCommandHandlerTest >> testConfigurationCommandHandler [
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

{ #category : #tests }
EDAMMCommandHandlerTest >> testLoggingCommandHandler [
	| handler |
	handler := EDAMMLoggingCommandHandler
		on: (WriteStream on: String new).
	handler handleCommand: nil within: nil.
	self assert: (handler stream contents includesSubstring: 'nil')
]

{ #category : #tests }
EDAMMCommandHandlerTest >> testSimpleCommandHandler [
	| handler |
	handler := EDAMMDummyCommandHandler new.
	handler handleCommand: nil within: nil.
	self assert: handler commandHandled
]

{ #category : #tests }
EDAMMCommandHandlerTest >> testSpecCommandHandler [
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
	command := Dictionary new add: 'spec file' -> file; yourself.
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

{ #category : #tests }
EDAMMCommandHandlerTest >> testSpecReaderCommandHandler [
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
