logging
logMessage: aMessage inCategory: aString
	| timestamp stream |
	timestamp := DateAndTime now.
	stream := String new writeStream.
	timestamp printYMDOn: stream.
	stream << '|'.
	timestamp printHMSOn: stream.
	Transcript
		print: '[';
		print: stream contents;
		print: '][';
		print: aString asUppercase;
		print: '] ';
		print: aMessage;
		cr.
	(aString ~= 'DEBUG' or: [ DateAndTime now seconds % 10 = 0 ])
		ifTrue: [ Transcript flush ]