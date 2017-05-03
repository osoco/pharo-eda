protected
buildWith: commandParams
	"Builds a command from given parameters"

	| command version |
	command := (self class environment
		at: (self commandClassForName: (commandParams at: #name))) new.
	command commandId: (commandParams at: #commandId).
	version := (commandParams at: #aggregateRootVersion ifAbsent: [ nil ]).
	version := version ifNil: [ commandParams at: #version ifAbsent: [ 0 ] ].
	command
		aggregateRootVersion: version.
		command version: version.
	(command isKindOf: EDAUserCommand)
		ifTrue:
			[ command authorUsername: (commandParams at: #authorUsername) ].
	^ command