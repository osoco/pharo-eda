BDD
applyEvents: aCollectionOfEvents onAggregateRoot: anAggregateRoot
	aCollectionOfEvents do: [ :anEvent | self applyEvent: anEvent onAggregateRoot: anAggregateRoot ]