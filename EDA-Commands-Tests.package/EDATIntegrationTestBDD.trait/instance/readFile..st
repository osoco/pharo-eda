helper
readFile: aFile
	| result stream |
	stream := aFile readStream.
	result := stream contents.
	stream close.
	^ result