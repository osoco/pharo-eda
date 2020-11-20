public-entity-creation
ensureAggregateRootForAggregateRootClass: anAggregateRootClassModel
	| aggregateRoot |
	^ aggregateRoots
		at: anAggregateRootClassModel
		ifAbsent: [ aggregateRoot := self createAggregateRoot: anAggregateRootClassModel.
			self addEntity: aggregateRoot.
			aggregateRoot ]