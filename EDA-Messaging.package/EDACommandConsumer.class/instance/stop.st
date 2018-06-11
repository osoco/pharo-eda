lifecycle
stop
	Transcript
		print: 'WARN: Stopping Command Consumer...';
		cr;
		flush.
	[ self busListener forceUnsubscribe ]
		on: Error
		do: [ :ex | 
			Transcript
				print: 'ERROR: Error stopping Command Consumer: ';
				print: ex description;
				cr;
				flush ]