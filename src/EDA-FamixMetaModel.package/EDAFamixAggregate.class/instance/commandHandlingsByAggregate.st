accessing
commandHandlingsByAggregate
	^ (self commandHandlings
		collect: [ :commandHandling | commandHandling command ]) asSet