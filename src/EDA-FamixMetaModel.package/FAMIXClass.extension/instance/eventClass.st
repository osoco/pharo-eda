*EDA-FamixMetaModel
eventClass
	<MSEProperty: #eventClass type: #EDAFamixEvent opposite: #eventClassModel>
	<derived>
	<MSEComment: 'The EDA Event to which this Event belongs to.'>
	^ self privateState attributeAt: #eventClass ifAbsent: [  ]