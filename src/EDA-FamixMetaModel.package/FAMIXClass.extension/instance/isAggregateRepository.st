*EDA-FamixMetaModel
isAggregateRepository
	<MSEProperty: #isAggregateRepository type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment:
		'If the Class is an EDA Aggregate Repository in the context of an EDA Aggregate.'>
	^ self smalltalkClass allSuperclasses includes: EDAAggregateRepository 