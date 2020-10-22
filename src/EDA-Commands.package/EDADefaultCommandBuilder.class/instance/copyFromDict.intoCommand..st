building
copyFromDict: aDictionary intoCommand: aCommand
	aDictionary
		associationsDo: [ :assoc | 
			| key |
			key := assoc key.
			key = 'version'
				ifFalse: [ key = 'id'
						ifTrue: [ key := 'aggregateRootId' ].
					[ aCommand
						instVarAt:
							(aCommand class
								instVarIndexFor: key
								ifAbsent: [ self logWarningMessage: 'No such inst var: ' , key ])
						put: assoc value ]
				on: Exception
				do: [ :ex | 
					self
						logWarningMessage: key greaseString , ' does not exist in ' , aCommand class greaseString ] ] ].
	aCommand
		aggregateRootVersion: (aDictionary at: #version ifAbsent: [ 0 ])