protected
buildWith: commandParams
	"Builds a command from given parameters"

	| command version |
	command := (self retrieveCommandClassFromParams: commandParams) new.
	command commandId: (commandParams at: #commandId).
	version := (commandParams at: #aggregateRootVersion ifAbsent: [ nil ]).
	version := version ifNil: [ commandParams at: #version ifAbsent: [ 0 ] ].
	command aggregateRootVersion: version.
	command version: version.
	command aggregateRootClass: (self retrieveAggregateRootClass: commandParams).
	(command isKindOf: EDAUserCommand)
		ifTrue:
			[ command authorUsername: (commandParams at: #authorUsername) ].
	^ command