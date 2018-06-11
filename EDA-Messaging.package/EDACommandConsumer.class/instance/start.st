lifecycle
start
	| listener |
	Transcript
		print: 'WARN: Starting Command Consumer...';
		cr.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | self consumeCommandMessage: message ].
	listener
		on: Error
		do: [ :error | 
			Transcript
				print: 'ERROR: Error in Command Consumer''s listener: ';
				print: error description;
				cr.
			self restart ]