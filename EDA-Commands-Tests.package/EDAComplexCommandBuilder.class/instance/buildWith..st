as yet unclassified
buildWith: commandParams
    | command params |
    "Builds a GCComplexCommand with given information"
    command := super buildWith: commandParams.
    params := (commandParams at: #params).
    command levels:
        (self extractLevels: (params at: #levels)).
    ^ command.