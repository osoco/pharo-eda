Class {
	#name : #EDAMMModuleFileTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMModuleFileTest >> testFileReadWithOneRow [
	| file entries |
	file := FileSystem workingDirectory / 'tests' / 'EDAMMModuleFileTest_testFileReadWithOneRow.csv'.
	file asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: 'module1';
				nextPut: $,;
				nextPutAll: '/tmp/module1/src';
				nextPut: Character cr;
				nextPut: Character lf ].
	entries := EDAMMModuleFile new readFile: file.
	self assert: entries isNotNil.
	self assert: (entries includesKey: 'module1').
	self assert: (entries at: 'module1') equals: '/tmp/module1/src'
]

{ #category : #tests }
EDAMMModuleFileTest >> testFileReadWithTwoRows [
	| file entries |
	file := FileSystem workingDirectory / 'tests' / 'EDAMMModuleFileTest_testFileReadWithTwoRows.csv'.
	file asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: 'module1';
				nextPut: $,;
				nextPutAll: '/tmp/module1/src';
				nextPut: Character cr;
				nextPut: Character lf;
				nextPutAll: 'module2';
				nextPut: $,;
				nextPutAll: '/temp/module2/src';
				nextPut: Character cr;
				nextPut: Character lf ].
	entries := EDAMMModuleFile new readFile: file.
	self assert: entries isNotNil.
	self assert: (entries includesKey: 'module1').
	self assert: (entries at: 'module1') equals: '/tmp/module1/src'.
	self assert: (entries includesKey: 'module2').
	self assert: (entries at: 'module2') equals: '/temp/module2/src'
]
