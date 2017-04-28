helper
retrieveApplyEventMethod: event
	| aux auxClass auxClassName result found |
	found := false.
	result := nil.
	auxClass := event class.
	auxClassName := auxClass greaseString.
	aux := 'apply' , auxClassName , ':'.
	[ found ]
		whileFalse: [ [ auxClassName isNotEmpty ]
				whileTrue: [ self class methodDictionary
						at: aux asSymbol
						ifPresent: [ :v | 
							found := true.
							result := aux ].
					auxClassName := auxClassName allButFirst.
					aux := 'apply' , auxClassName , ':' ].
			auxClass := auxClass superclass.
			auxClassName := auxClass greaseString.
			found := auxClass ~= EDAEventSourcingEvent.
			aux := 'apply' , auxClass greaseString , ':' ].
	^ result