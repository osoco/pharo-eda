helper
retrieveApplyEventMethod: event withLogging: aFlag
	| aux auxClass auxClassName result found |
	found := false.
	result := nil.
	auxClass := event class.
	auxClassName := auxClass greaseString.
	aux := self
		buildApplyEventMethodNameForEvent: auxClassName
		andVersion: event version.
	[ found ]
		whileFalse: [ [ auxClassName isNotEmpty ]
				whileTrue: [ self class methodDictionary
						at: aux asSymbol
						ifPresent: [ :v | 
							found := true.
							^ aux ]
						ifAbsent: [ aFlag
								ifTrue: [ self
										logTraceMessage: ((WriteStream on: String new) nextPutAll: self class greaseString; nextPutAll: '>>'; nextPutAll: aux; nextPutAll: ' not found.'; close; contents) ] ].
					auxClassName := auxClassName allButFirst.
					aux := self
						buildApplyEventMethodNameForEvent: auxClassName
						andVersion: event version ].
			auxClass := auxClass superclass.
			auxClassName := auxClass greaseString.
			found := auxClass ~= EDAEventSourcingEvent.
			aux := self
				buildApplyEventMethodNameForEvent: auxClass greaseString
				andVersion: event version ].
	^ result