initialization
initialize
	super initialize.
	event := FMNullMultivalueLink
		on: self
		opposite: #eventClass:
		selector: #event.
	aggregatePublishers := FMNullMultivalueLink
		on: self
		opposite: #event:
		selector: #aggregatePublishers.
	commandTriggers  := FMNullMultivalueLink
		on: self
		opposite: #event:
		selector: #commandTriggers 