handling
readFuelFromFileNamed: aString inFolder: aFolder
	^ self readFuelFromFileNamed: (aFolder / aString)