builder
buildWith: commandParams
	"Builds a command from given parameters"

	| command |
	command := super buildWith: commandParams.
	(commandParams at: #params)
		associationsDo: [ :assoc | | key |
			key := assoc key.
			(key = 'id') ifTrue: [ key := 'aggregateRootId' ].
			self class
				instVarAt:
					(self class
						instVarIndexFor: key
						ifAbsent: [ Transcript
								print: 'No such inst var: ';
								print: key;
								cr ])
				put: assoc value ].
	^ command