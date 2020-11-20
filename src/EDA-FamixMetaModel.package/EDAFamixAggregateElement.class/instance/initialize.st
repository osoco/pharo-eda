initialization
initialize
	super initialize.
	aggregateElementClassModel := FMNullMultivalueLink
		on: self
		opposite: #aggregateElement:
		selector: #aggregateElementClassModel.
	aggregateElementUsers := FMNullMultivalueLink
		on: self
		opposite: #aggregateElement:
		selector: #aggregateElementUsers.