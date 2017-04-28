helper
readFromContract: evtName version: version using: aBlock
	| result file fileContents |
	file := aBlock cull: evtName cull: version.
	fileContents := file readStream.
	result := NeoJSONReader fromString: fileContents.
	fileContents close.
	^ result