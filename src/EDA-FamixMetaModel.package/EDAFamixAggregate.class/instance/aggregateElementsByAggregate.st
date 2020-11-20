accessing
aggregateElementsByAggregate
	^ (self aggregateRootsByAggregate
		flatCollect:
			[ :anAggregateRoot | anAggregateRoot aggregateElementUsingsForAggregateRoot ])
		asSet