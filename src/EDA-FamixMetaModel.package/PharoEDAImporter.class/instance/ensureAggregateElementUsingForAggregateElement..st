public-entity-creation
ensureAggregateElementUsingForAggregateElement: anEDAAggregateElement

	| aggregateElementUsing |
	^ aggregateElementUsings
		at: anEDAAggregateElement
		ifAbsent: [ aggregateElementUsing := self createAggregateElementUsing: anEDAAggregateElement.
			aggregateElementUsing ifNotNil: [ self addEntity: aggregateElementUsing ].
			aggregateElementUsing ]