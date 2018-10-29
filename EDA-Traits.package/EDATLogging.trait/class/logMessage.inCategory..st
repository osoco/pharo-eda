logging
logMessage: aMessage inCategory: aString
	Transcript
		print: DateAndTime now asFileNameCompatibleString;
		print: '[';
		print: aString asUppercase;
		print: '] ';
		print: aMessage;
		cr