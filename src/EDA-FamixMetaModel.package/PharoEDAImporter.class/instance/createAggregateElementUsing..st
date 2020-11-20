public-entity-creation
createAggregateElementUsing: anEDAAggregateElement
	| model aggregateElementUsing aggregateRootClassModel |
	model := anEDAAggregateElement aggregateElementClassModel mooseModel.
	aggregateRootClassModel := model allModelClasses
		detect: [ :classModel | 
			classModel smalltalkClass category
				=
					anEDAAggregateElement aggregateElementClassModel smalltalkClass
						category and: [ classModel isAggregateRoot ] ].
	aggregateElementUsing := EDAFamixAggregateElementUsing new
		aggregate: (self ensureAggregateRootForAggregateRootClass: aggregateRootClassModel);
		aggregateElement: anEDAAggregateElement.
	aggregateElementUsings
		at: anEDAAggregateElement
		put: aggregateElementUsing.
	^ aggregateElementUsing