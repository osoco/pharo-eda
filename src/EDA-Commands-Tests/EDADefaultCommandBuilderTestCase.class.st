Class {
	#name : #EDADefaultCommandBuilderTestCase,
	#superclass : #TestCase,
	#category : #'EDA-Commands-Tests'
}

{ #category : #'as yet unclassified' }
EDADefaultCommandBuilderTestCase >> fixme_testCreatesComplexCommands [
	| builder map actualCommand expectedCommand |
	map := Dictionary new.
	map
		add: 'name' -> 'COMPLEX_COMMAND';
		add: 'commandId' -> 'command-1';
		add: 'aggregateRootVersion' -> '2';
		add: 'authorUsername' -> 'me@example.com';
		add:
			'params'
				->
					(Dictionary new
						add: 'applicationKey' -> 'app-1';
						yourself).
	expectedCommand := EDAComplexCommand new
		commandId: 'command-1';
		aggregateRootVersion: 2;
		authorUsername: 'me@example.com';
		applicationKey: 'app-1';
		levels: OrderedCollection new.
	builder := EDAComplexCommandBuilder new.
	actualCommand := builder buildWith: map.
	self assert: actualCommand equals: expectedCommand.
	self assert: actualCommand levels equals: expectedCommand levels
]

{ #category : #'as yet unclassified' }
EDADefaultCommandBuilderTestCase >> testCreatesComplexCommands [
	
]
