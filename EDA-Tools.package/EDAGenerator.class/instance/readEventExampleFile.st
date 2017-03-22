helper
readEventExampleFile
	| result stream |
	stream := self eventFile readStream.
	result := stream contents.
	stream close.
	^ result