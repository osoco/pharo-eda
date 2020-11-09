accessing
aggregate: anAggregateModel 

	aggregate := FMMultivalueLink
		on: self
		update: #eventPublishings
		from: self aggregate
		to: anAggregateModel

