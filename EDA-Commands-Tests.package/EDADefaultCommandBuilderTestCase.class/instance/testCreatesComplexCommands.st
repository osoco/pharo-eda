as yet unclassified
testCreatesComplexCommands
    | builder map level1 level2
      actualCommand expectedCommand |
    level1 := GCLevel new levelName: 'first'; levelRangeSize: 100.
    level2 := GCLevel new levelName: 'second'.
    map := { 
        'name' -> 'COMPLEX_COMMAND'.
        'commandId' -> 'command-1'.
        'aggregateRootVersion' -> '2'.
        'authorUsername' -> 'me@example.com'.
        'params' -> {
            'applicationKey' -> 'app-1'.
            'levels' -> {
                { 'levelName' -> 'first' . 'levelRangeSize' -> 100 } asDictionary.
                { 'levelName' -> 'second' } asDictionary.
            } asOrderedCollection
        } asDictionary
    } asDictionary.
    expectedCommand :=
        EDAComplexCommand new
            commandId: 'command-1';
            aggregateRootVersion: 2;
            authorUsername: 'me@example.com';
            applicationKey: 'app-1';
            levels: { level1. level2 } asOrderedCollection.
    builder := EDAComplexCommandBuilder new.
    actualCommand := builder buildWith: map.
    self assert: actualCommand equals: expectedCommand.
    self assert: (actualCommand levels)
         equals: (expectedCommand levels).