*EDA-FamixMetaModel
aggregate
	<MSEProperty: #aggregate type: #EDAFamixAggregate opposite: #aggregateRoot>
	<derived>
	<MSEComment: 'The EDA Aggregate to which this Aggregate Root belongs to.'>
	^ self privateState attributeAt: #aggregate