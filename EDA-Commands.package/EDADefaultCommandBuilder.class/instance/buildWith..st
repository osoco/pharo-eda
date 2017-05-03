builder
buildWith: commandParams
	"Builds a command from given parameters"

	| command |
	command := super buildWith: commandParams.
	(commandParams at: #params)
		associationsDo: [ :assoc | (self class instVarAt: (self class instVarIndexFor: assoc key ifAbsent: [ Transcript print: 'No such inst var: '; print: assoc key; cr ])) put: assoc value ].
	^ command