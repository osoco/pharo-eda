logging
nextPutAll: aString
	| result |
	result := self defaultStream.
	result nextPutAll: aString.
	^ result