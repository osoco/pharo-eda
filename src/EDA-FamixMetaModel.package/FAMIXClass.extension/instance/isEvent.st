*EDA-FamixMetaModel
isEvent
	<MSEProperty: #isEvent type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment: 'If the Class is an EDA Event.'>
	| class |
	class := self smalltalkClass.
	^ (class allSuperclasses includes: EDACommandResultEvent)
		and:
			[ (class = EDADeleteCommandResultEvent
				or: [ class = EDAUserCommandResultEvent ]) not ] 