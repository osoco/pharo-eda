logging
logMessage: aMessage inCategory: aString inStream: aStream beautify: beautify
	| timestamp stream |
	stream := WriteStream on: String new.
	beautify ifTrue: [ 
	stream << '['.
	timestamp := DateAndTime now.
	timestamp printYMDOn: stream.
	stream << '|'.
	timestamp printHMSOn: stream.
	stream << ']['.
	stream << aString asUppercase.
	stream << '] ' ].
	aMessage ifNotNil: [ :msg | stream nextPutAll: msg ].
	(beautify ifTrue: [ (aMessage endsWithSubCollection: '.')
		ifFalse: [ stream << '.' ] ]).
	aStream
		<< stream contents;
		nextPut: Character cr.
	(aString = 'TRACE' or: [ aString = 'DEBUG' or: [ DateAndTime now seconds % 10 = 0 ] ])
		ifTrue: [ aStream flush ]