logging
print: aString
	| result |
	result := self defaultStream.
	result print: aString.
	^ result