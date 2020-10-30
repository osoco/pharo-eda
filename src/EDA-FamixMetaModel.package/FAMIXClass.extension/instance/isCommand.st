*EDA-FamixMetaModel
isCommand
	<MSEProperty: #isCommand type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment:
		'If the Class is an EDA Command.'>
	^ self smalltalkClass allSuperclasses includes: EDACommand