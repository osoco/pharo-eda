Class {
	#name : #EDAMMSpecIteratorCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMSpecIteratorCommandHandlerTest >> testSpecIteratorCommandHandler [
	| handler command file specsFound |
	file := FileSystem workingDirectory / 'tests'
		/
			'EDAMMSpecIteratorCommandHandlerTest_testSpecIteratorCommandHandler.csv'.
	file exists ifTrue: [ file delete ].
	file asFileReference
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
	command := Dictionary new
		add: 'specs file' -> file;
		yourself.
	specsFound := OrderedCollection new.
	handler := EDAMMSpecIteratorCommandHandler
		for: [ :spec :cmd :ctx | specsFound add: spec ].
	handler handleCommand: command within: Dictionary new.
	self assert: specsFound isNotEmpty.
	self assert: specsFound size equals: 2.
	self
		assert: specsFound first
		equals:
			(Dictionary new
				add: 'input module' -> 'pharo-eda';
				add: 'input package' -> 'EDA-Events';
				add: 'input class' -> 'EDAEventSourcingEvent';
				add: 'output module' -> 'pharo-eda-api';
				add: 'output package' -> 'EDAAPI-Events';
				add: 'output class' -> 'EDAEventSourcingEvent';
				yourself).
	self
		assert: specsFound second
		equals:
			(Dictionary new
				add: 'input module' -> 'pharo-eda';
				add: 'input package' -> 'EDA-Domain';
				add: 'input class' -> 'EDAAggregateRoot';
				add: 'output module' -> 'pharo-eda-api';
				add: 'output package' -> 'EDAAPI-Aggregates';
				add: 'output class' -> 'EDAAggregateRoot';
				yourself)
]
