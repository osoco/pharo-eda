initialization
initialize
	super initialize.
	commandClassModel := FMNullMultivalueLink
		on: self
		opposite: #commandClass:
		selector: #commandClassModel.
	aggregateHandlers := FMNullMultivalueLink
		on: self
		opposite: #command:
		selector: #aggregateHandlers.
	eventTriggerings := FMNullMultivalueLink
		on: self
		opposite: #command:
		selector: #eventTriggerings