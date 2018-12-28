helper
retrieveHandlerSelectorSymbol: aCommand
	| result |
	aCommand isDelete
		ifTrue: [ result := #handleDeleteCommand: ]
		ifFalse: [ | pragmas methods |
			pragmas := Pragma
				allNamed: 'useAsCommandHandlerFor:'
				in: aCommand class aggregateRootClass.
			methods := (pragmas
				select: [ :p | (p argumentAt: 1) = aCommand className ])
				collect: [ :p | p method ].
			methods
				ifEmpty: [ self
						logErrorMessage:
							'No pragma-based methods found to handle '
								, aCommand className greaseString ].
			result := methods
				ifEmpty: [ ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol ]
				ifNotEmpty: [ methods first selector ] ].
	^ result