printing
printOn: stream
	stream
		<< 'Event [';
		print: self index;
		<< '/';
		print: self projectionSourceEventsSize;
		<< '] ';
		print: self event class name;
		<< ' not projected to ';
		print: self projection name;
		<< '.'