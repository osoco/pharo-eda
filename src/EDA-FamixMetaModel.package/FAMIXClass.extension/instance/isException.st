*EDA-FamixMetaModel
isException
	<MSEProperty: #isException type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment:
		'If the Class is an Exception in the context of an EDA Aggregate.'>
	^ self smalltalkClass allSuperclasses includes: Exception