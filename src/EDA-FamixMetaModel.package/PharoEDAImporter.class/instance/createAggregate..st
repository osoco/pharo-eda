public-entity-creation
createAggregate: anAggregateRootClassModel
	| aggregate |
	aggregate := aggregates
		at: anAggregateRootClassModel
		put:
			(EDAFamixAggregate new
				aggregateRoot: (self ensureAggregateRootForAggregateRootClass: anAggregateRootClassModel);
				parentPackage: anAggregateRootClassModel parentPackage;
				yourself).
	^ aggregate