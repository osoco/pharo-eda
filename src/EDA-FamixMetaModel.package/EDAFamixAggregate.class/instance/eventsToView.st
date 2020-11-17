accessing
eventsToView
	^ self eventPublishingsByAggregate
		, self eventTriggeringsByAggregateCommands