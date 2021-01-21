Class {
	#name : #EDADefaultCommandBuilderTestCase,
	#superclass : #TestCase,
	#category : 'EDA-Commands-Tests'
}

{ #category : #'as yet unclassified' }
EDADefaultCommandBuilderTestCase >> testCreatesComplexCommands [
    | builder map level1 level2
      actualCommand expectedCommand |
    map := { 
        'name' -> 'COMPLEX_COMMAND'.
        'commandId' -> 'command-1'.
        'aggregateRootVersion' -> '2'.
        'authorUsername' -> 'me@example.com'.
        'params' -> {
            'applicationKey' -> 'app-1'
        } asDictionary
    } asDictionary.
    expectedCommand :=
        EDAComplexCommand new
            commandId: 'command-1';
            aggregateRootVersion: 2;
            authorUsername: 'me@example.com';
            applicationKey: 'app-1';
            levels: { } asOrderedCollection.
    builder := EDAComplexCommandBuilder new.
    actualCommand := builder buildWith: map.
    self assert: actualCommand equals: expectedCommand.
    self assert: (actualCommand levels)
         equals: (expectedCommand levels).

]
