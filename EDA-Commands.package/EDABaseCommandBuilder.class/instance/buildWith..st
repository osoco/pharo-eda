protected
buildWith: commandParams
    "Builds a command from given parameters"
    | command |
    command :=
        (self commandClassForName:
            (commandParams at: #name))
        asClass new.
    command commandId:
        (commandParams at: #commandId).
    command aggregateRootVersion:
        (commandParams at: #aggregateRootVersion).
    (command isKindOf: EDAUserCommand) ifTrue:
        [ command authorUsername:
	           (commandParams at: #authorUsername) ].
    ^ command.