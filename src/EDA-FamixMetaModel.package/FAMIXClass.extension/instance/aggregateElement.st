*EDA-FamixMetaModel
aggregateElement
	<MSEProperty: #aggregateElement type: #EDAFamixAggregateElement opposite: #aggregateElementClassModel >
	<derived>
	<MSEComment: 'The EDA AggregateElement to which this Class belongs to.'>
	^ self privateState attributeAt: #aggregateElement ifAbsent: [  ]