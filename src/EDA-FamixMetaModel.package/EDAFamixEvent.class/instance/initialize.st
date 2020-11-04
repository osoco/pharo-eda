initialization
initialize
	super initialize.
	event := FMNullMultivalueLink
		on: self
		opposite: #eventClass:
		selector: #event