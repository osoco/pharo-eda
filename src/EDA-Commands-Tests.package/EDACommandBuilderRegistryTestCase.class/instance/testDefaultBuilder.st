as yet unclassified
testDefaultBuilder
    | builder |
    builder := EDACommandBuilderRegistry lookupBuilder: 'DELETE_ACHIEVEMENT_TYPE'.
    self assert: builder class name equals: #EDADefaultCommandBuilder.