builder
buildWith: commandParams
    "Builds a command from given parameters"
    | command |
    command := super buildWith: commandParams.
    (commandParams at: #params)
        associationsDo: [ :assoc |
	         command instVarNamed: assoc key put: assoc value ].
    ^ command.