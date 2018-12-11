helper
readCommandExampleFile
	| result stream |
	stream := self commandFile readStream.
	result := stream contents.
	stream close.
	^ result