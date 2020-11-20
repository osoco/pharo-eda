as yet unclassified
aggregateElementUsingsForAggregateRoot
	^ (self aggregateElementUsings
		collect: [ :aggregateElementUsing | aggregateElementUsing aggregateElement ]) asSet