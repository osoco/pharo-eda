public-entity-creation
createAggregateElement: anAggregateElementClassModel
	| aggregateElement |
	aggregateElement := aggregateElements
		at: anAggregateElementClassModel
		put:
			(EDAFamixAggregateElement new
				aggregateElementClassModel: anAggregateElementClassModel;
				parentPackage: anAggregateElementClassModel parentPackage;
				yourself).
	^ aggregateElement