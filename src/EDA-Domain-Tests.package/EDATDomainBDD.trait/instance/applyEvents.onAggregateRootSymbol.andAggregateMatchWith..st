BDD
applyEvents: aCollectionOfEvents onAggregateRootSymbol: anAggregateRootSymbol andAggregateMatchWith: aBlock
| aggregateRoot |
aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	aCollectionOfEvents do: [ :anEvent | self applyEvent: anEvent onAggregateRoot: aggregateRoot ].
	aBlock value: aggregateRoot