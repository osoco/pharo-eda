public-entity-creation
createAggregateRoot: anAggregateRootClassModel
	| aggregateRoot |
	aggregateRoot := aggregateRoots
		at: anAggregateRootClassModel
		put:
			(EDAFamixAggregateRoot new
				aggregateRootClassModel: anAggregateRootClassModel;
				parentPackage: anAggregateRootClassModel parentPackage;
				yourself).
	^ aggregateRoot