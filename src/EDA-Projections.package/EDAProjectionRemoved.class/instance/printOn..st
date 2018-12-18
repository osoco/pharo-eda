printing
printOn: stream
	stream
		<< 'Projection ';
		print: self projection name;
		<< ' removed'