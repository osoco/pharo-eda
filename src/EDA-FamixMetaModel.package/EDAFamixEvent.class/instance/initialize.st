initialization
initialize
	super initialize.
	eventClassModel := FMNullMultivalueLink
		on: self
		opposite: #eventClass:
		selector: #eventClassModel.
	aggregatePublishers := FMNullMultivalueLink
		on: self
		opposite: #event:
		selector: #aggregatePublishers.
	commandTriggers := FMNullMultivalueLink
		on: self
		opposite: #event:
		selector: #commandTriggers