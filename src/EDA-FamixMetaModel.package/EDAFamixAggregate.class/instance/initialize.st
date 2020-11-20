initialization
initialize
	super initialize.
	aggregateRoot := FMNullMultivalueLink
		on: self
		opposite: #aggregate:
		selector: #aggregateRoot.
	commandHandlings := FMNullMultivalueLink
		on: self
		opposite: #aggregate:
		selector: #commandHandlings.
	eventPublishings := FMNullMultivalueLink
		on: self
		opposite: #aggregate:
		selector: #eventPublishings.
	aggregateElementUsings  := FMNullMultivalueLink
		on: self
		opposite: #aggregate:
		selector: #aggregateElementUsings