*EDA-FamixMetaModel
commandClass
	<MSEProperty: #commandClass type: #EDAFamixCommand opposite: #commandClassModel>
	<derived>
	<MSEComment: 'The EDA Command to which this Command belongs to.'>
	^ self privateState attributeAt: #commandClass ifAbsent: [  ]