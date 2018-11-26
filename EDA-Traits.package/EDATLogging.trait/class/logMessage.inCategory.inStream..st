logging
logMessage: aMessage inCategory: aString inStream: aStream
	| timestamp stream |
	stream := WriteStream on: String new.
	stream << '['.
	timestamp := DateAndTime now.
	timestamp printYMDOn: stream.
	stream << '|'.
	timestamp printHMSOn: stream.
	stream << ']['.
	stream << aString asUppercase.
	stream << '] '.
	stream << aMessage.
	stream << '.'.
	aStream
		print: stream contents;
		nextPut: Character cr.
	(aString = 'DEBUG' or: [ DateAndTime now seconds % 10 = 0 ])
		ifTrue: [ aStream flush ]