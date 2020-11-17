as yet unclassified
eventPublishingsByCommandAggregates
	^ self aggregatesToView
		flatCollect: [ :aggregate | aggregate eventPublishingsByAggregate ]