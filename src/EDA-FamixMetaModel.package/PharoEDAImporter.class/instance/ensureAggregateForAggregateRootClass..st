public-entity-creation
ensureAggregateForAggregateRootClass: anAggregateRootClassModel
	| aggregate |
	^ aggregates
		at: anAggregateRootClassModel
		ifAbsent: [ 
			aggregate := self createAggregate: anAggregateRootClassModel.
			self addEntity: aggregate.
			aggregate ]