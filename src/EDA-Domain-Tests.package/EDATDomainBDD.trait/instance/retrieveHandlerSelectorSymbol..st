helper
retrieveHandlerSelectorSymbol: aCommand
	| result |
	aCommand isDelete
		ifTrue: [ result := #handleDeleteCommand: ]
		ifFalse: [ | pragmas methods |
			pragmas := Pragma allNamed: 'useAsCommandHandlerFor:' in: ATSForm.
			methods := pragmas
				select: [ :p | (p argumentAt: 1) = #ATSCreateForm ]
				thenCollect: [ :p | p method ].
			result := methods
				ifEmpty: [ ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol ]
				ifNotEmpty: [ methods first selector ] ].
	^ result