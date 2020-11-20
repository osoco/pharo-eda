*EDA-FamixMetaModel
aggregateRoot
	<MSEProperty: #aggregateRoot type: #EDAFamixAggregateRoot opposite: #aggregateRootClassModel>
	<derived>
	<MSEComment: 'The EDA Aggregate Root to which this Aggregate Root belongs to.'>
	^ self privateState attributeAt: #aggregateRoot ifAbsent: [  ]