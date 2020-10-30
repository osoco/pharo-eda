*EDA-FamixMetaModel
isEvent
	<MSEProperty: #isEvent type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment: 'If the Class is an EDA Event.'>
	^ self smalltalkClass allSuperclasses includes: EDAEventSourcingEvent 