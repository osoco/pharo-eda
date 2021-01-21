Class {
	#name : #EDACommandBuilderRegistryTestCase,
	#superclass : #TestCase,
	#category : 'EDA-Commands-Tests'
}

{ #category : #'as yet unclassified' }
EDACommandBuilderRegistryTestCase >> testDefaultBuilder [
    | builder |
    builder := EDACommandBuilderRegistry lookupBuilder: 'DELETE_ACHIEVEMENT_TYPE'.
    self assert: builder class name equals: #EDADefaultCommandBuilder.
]
