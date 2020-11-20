accessing
aggregateElement:  anAggregateElementModel
	aggregateElement  := FMMultivalueLink
		on: self
		update: #aggregateElementUsers
		from: self aggregateElement 
		to: anAggregateElementModel