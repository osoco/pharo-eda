initialization
initialize
	super initialize.
	aggregateRootClassModel := FMNullMultivalueLink
		on: self
		opposite: #aggregateRoot:
		selector: #aggregateRootClassModel.
	aggregateElementUsings := FMNullMultivalueLink
		on: self
		opposite: #aggregate:
		selector: #aggregateElementUsings