logging
nextPut: aCharacter
	| result |
	result := self defaultStream.
	result nextPut: aCharacter.
	^ result