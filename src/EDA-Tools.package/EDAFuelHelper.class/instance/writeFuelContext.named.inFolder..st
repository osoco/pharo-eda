handling
writeFuelContext: aContext named: aString inFolder: aFolder
	| result |
	result := aFolder / 'session.fuel'.
	FLSerializer serialize: aContext toFileNamed: result pathString.
	^ result