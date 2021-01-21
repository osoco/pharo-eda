Class {
	#name : #EDAFuelHelper,
	#superclass : #Object,
	#category : 'EDA-Tools'
}

{ #category : #handling }
EDAFuelHelper >> readFuelFromFileNamed: aFileReference [
	| aContext |
	aContext := FLMaterializer
		materializeFromFileNamed: aFileReference pathString.
	^ Process forContext: aContext priority: Processor activePriority
]

{ #category : #handling }
EDAFuelHelper >> readFuelFromFileNamed: aString inFolder: aFolder [
	^ self readFuelFromFileNamed: (aFolder / aString)
]

{ #category : #handling }
EDAFuelHelper >> writeFuelContext: aContext named: aString inFolder: aFolder [
	| result |
	result := aFolder / aString.
	FLSerializer serialize: aContext toFileNamed: result pathString.
	^ result
]
