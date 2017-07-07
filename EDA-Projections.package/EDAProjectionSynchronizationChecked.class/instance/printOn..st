printing
printOn: stream
	self synchronized
		ifFalse: [ stream << '[WARNING] ' ].
	stream
		<< 'Projection ';
		print: self projection name.
	self synchronized
		ifTrue: [ stream << ' seems synchronized' ]
		ifFalse: [ stream << ' seems NOT synchronized ' ].
	stream
		<< ' with ';
		print: self totalProjectedEventsSize;
		<< ' of ';
		print: self projectionSourceEventsSize;
		<< ' total events'