lifecycle
restart
	Transcript
		print: 'WARN: Restarting Command Consumer...';
		cr.
	[ self stop ]
		ensure: [ self start ]