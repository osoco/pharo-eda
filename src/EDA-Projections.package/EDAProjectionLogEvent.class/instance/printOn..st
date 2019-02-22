printing
printOn: stream
	| indexPart outcomePart |
	indexPart := self index ifNil: [ '' ] ifNotNil: [ :i | '[' , i greaseString , '/' , self projectionSourceEventsSize greaseString , ']' ].
	outcomePart := self class successOutcome
		ifTrue: [ '' ]
		ifFalse: [ ' NOT' ].
	stream
		<< 'Event ';
		<< indexPart;
		print: self event class name;
		<< '(';
		<< self event uniqueId greaseString;
		<< ')';
		<< outcomePart;
		<< ' projected to ';
		print: self projection name