Class {
	#name : #EDAMMSpecFileTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMSpecFileTest >> testFileReadWithOneRow [
	| file entries |
	file := FileSystem workingDirectory / 'tests'
		/ 'EDAMMSpecFileTest_testFileReadWithOneRow.csv'.
	file exists
		ifTrue: [ file delete ].
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
				nextPutAll: 'EDAAPI-Events-Events';
				nextPut: $,;
				nextPutAll: 'EDAEventSourcingEvent';
				nextPut: Character cr;
				nextPut: Character lf ].
	entries := EDAMMSpecFile new readFile: file.
	self assert: entries isNotNil.
	self assert: (entries first includesKey: 'input module').
	self assert: (entries first at: 'input module') equals: 'pharo-eda'.
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
EDAMMSpecFileTest >> testFileReadWithTwoRows [
	| file entries |
	file := FileSystem workingDirectory / 'tests'
		/ 'EDAMMSpecFileTest_testFileReadWithTwoRows.csv'.
	file exists
		ifTrue: [ file delete ].
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
				nextPutAll: 'EDAAPI-Events-Events';
				nextPut: $,;
				nextPutAll: 'EDAEventSourcingEvent';
				nextPut: Character cr;
				nextPut: Character lf;
				nextPutAll: 'pharo-eda';
				nextPut: $,;
				nextPutAll: 'EDA-Voyage-EventStore';
				nextPut: $,;
				nextPutAll: 'EDAMongoEventStore';
				nextPut: $,;
				nextPutAll: 'pharo-eda-adapters';
				nextPut: $,;
				nextPutAll: 'EDAA-EventStore-Voyage';
				nextPut: $,;
				nextPutAll: 'EDAA-EventStore-Voyage';
				nextPut: $,;
				nextPutAll: 'EDAAMongoEventStore';
				nextPut: Character cr;
				nextPut: Character lf ].
	entries := EDAMMSpecFile new readFile: file.
	self assert: entries isNotNil.
	self assert: entries isNotEmpty.
	self assert: (entries first includesKey: 'input module').
	self assert: (entries first at: 'input module') equals: 'pharo-eda'.
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
		equals: 'EDAEventSourcingEvent'.
	self assert: entries size > 1.
	self assert: (entries second includesKey: 'input module').
	self assert: (entries second at: 'input module') equals: 'pharo-eda'.
	self assert: (entries second includesKey: 'input package').
	self
		assert: (entries second at: 'input package')
		equals: 'EDA-Voyage-EventStore'.
	self assert: (entries second includesKey: 'input class').
	self
		assert: (entries second at: 'input class')
		equals: 'EDAMongoEventStore'.
	self assert: (entries first includesKey: 'output module').
	self
		assert: (entries second at: 'output module')
		equals: 'pharo-eda-adapters'.
	self assert: (entries second includesKey: 'output package').
	self
		assert: (entries second at: 'output package')
		equals: 'EDAA-EventStore-Voyage'.
	self assert: (entries second includesKey: 'output class').
	self
		assert: (entries second at: 'output class')
		equals: 'EDAAMongoEventStore'
]
