printing
printOn: stream
	stream
		<< 'Projection ';
		print: self projection class name;
		<< ' removed'