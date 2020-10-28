*EDA-FamixMetaModel
isAggregateRoot
	<MSEProperty: #isAggregateRoot type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment:
		'If the Class is an EDA Aggregate Root in the context of an EDA Aggregate.'>
	^ self smalltalkClass allSuperclasses includes: EDAAggregateRoot