*EDA-FamixMetaModel
eventClass
	<MSEProperty: #eventClass type: #EDAFamixEvent opposite: #event>
	<derived>
	<MSEComment: 'The EDA Event to which this Event belongs to.'>
	^ self privateState attributeAt: #event