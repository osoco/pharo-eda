initialization
initialize
	super initialize.
	command := FMNullMultivalueLink
		on: self
		opposite: #commandClass:
		selector: #command.

	aggregateHandlers  := FMNullMultivalueLink
		on: self
		opposite: #command:
		selector: #aggregateHandlers .