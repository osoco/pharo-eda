*EDA-FamixMetaModel
commandClass
	<MSEProperty: #commandClass type: #EDAFamixCommand opposite: #command>
	<derived>
	<MSEComment: 'The EDA Command to which this Command belongs to.'>
	^ self privateState attributeAt: #command