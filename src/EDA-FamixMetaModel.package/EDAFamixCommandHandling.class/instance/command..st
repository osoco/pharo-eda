accessing
command: aCommand
	command := FMMultivalueLink
		on: self
		update: #aggregateHandlers 
		from: self command
		to: aCommand