as yet unclassified
testCreatesDeleteAchievementTypeCommands
    | builder map params
      actualCommand expectedCommand |
    params := {
        'applicationKey' -> 'app-1'
    } asDictionary.
    map := {
        'name' -> 'DELETE_ACHIEVEMENT_TYPE'.
        'commandId' -> 'c1'.
        'aggregateRootVersion' -> '2'.
        'authorUsername' -> 'me@example.com'.
        'params' -> params
    } asDictionary.
    expectedCommand :=
        GCDeleteAchievementType new
            commandId: 'c1';
            aggregateRootVersion: 2;
            authorUsername: 'me@example.com';
            applicationKey: 'app-1'.
    builder := EDADefaultCommandBuilder new.
    actualCommand := builder buildWith: map.
    self assert: actualCommand equals: expectedCommand.
    self assert: (actualCommand applicationKey)
         equals: expectedCommand applicationKey.