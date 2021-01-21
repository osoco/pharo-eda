handling
writeFuelContext: aContext named: aString inFolder: aFolder
	| result |
	result := aFolder / aString.
	FLSerializer serialize: aContext toFileNamed: result pathString.
	^ result