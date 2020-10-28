public-entity-creation
createAggregate: anAggregateRootClassModel
	| aggregate |
	aggregate := aggregates
		at: anAggregateRootClassModel
		put:
			(EDAFamixAggregate new
				aggregateRoot: anAggregateRootClassModel;
				parentPackage: anAggregateRootClassModel parentPackage;
				yourself).
	^ aggregate