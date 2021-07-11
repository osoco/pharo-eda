Class {
	#name : #EDAMMClassFileTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMClassFileTest >> testReadEDACommandConsumer [
	| folder entries |
	folder := FileSystem workingDirectory / 'src'.
	entries := EDAMMClassFile new
		readClassNamed: 'EDACommandConsumer'
		inPackage: 'EDA-Messaging'
		inFolder: folder.
	self assert: entries isNotNil
]

{ #category : #tests }
EDAMMClassFileTest >> testWriteEDACommandConsumer [
	| folder file defs |
	folder := FileSystem workingDirectory / 'tests'.
	defs := EDAMMClassFile new readClassNamed: 'EDACommandConsumer' inPackage: 'EDA-Messaging' inFolder: FileSystem workingDirectory / 'src'.
	file := EDAMMClassFile new
		writeClassNamed: 'EDACommandConsumer'
		withDefinitions: defs
		inFolder: folder.
	self assert: file isNotNil
]
