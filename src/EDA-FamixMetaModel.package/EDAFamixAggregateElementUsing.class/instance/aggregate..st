accessing
aggregate: anAggregateModel
	aggregate := FMMultivalueLink
		on: self
		update: #aggregateElementUsings 
		from: self aggregate
		to: anAggregateModel