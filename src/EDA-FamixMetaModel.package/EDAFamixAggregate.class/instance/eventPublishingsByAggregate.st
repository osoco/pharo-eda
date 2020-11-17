accessing
eventPublishingsByAggregate
	^ (self eventPublishings
		collect: [ :eventPublishing | eventPublishing event ]) asSet