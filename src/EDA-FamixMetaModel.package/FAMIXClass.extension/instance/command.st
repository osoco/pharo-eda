*EDA-FamixMetaModel
command
	<MSEProperty: #command type: #EDAFamixCommand opposite: #command>
	<derived>
	<MSEComment: 'The EDA Command to which this Command belongs to.'>
	^ self privateState attributeAt: #command