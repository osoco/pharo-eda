API
lookupBuilder: commandName
    "Retrieves the builder for given command name"
    ^ self mapping at: commandName ifAbsent: [ ^ EDADefaultCommandBuilder new ].