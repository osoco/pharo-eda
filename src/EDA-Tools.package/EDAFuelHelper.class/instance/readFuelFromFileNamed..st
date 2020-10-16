handling
readFuelFromFileNamed: aFileReference
	| aContext |
	aContext := FLMaterializer
		materializeFromFileNamed: aFileReference pathString.
	^ Process forContext: aContext priority: Processor activePriority