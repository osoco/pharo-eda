Class {
	#name : #EDATestDeleteCommandMessage,
	#superclass : #EDATestCommandMessage,
	#category : #'EDA-Domain-Tests'
}

{ #category : #'instance creation' }
EDATestDeleteCommandMessage class >> checkValidClass: anAggregateClass [.
	(anAggregateClass == EDAAggregateRoot or: [ anAggregateClass inheritsFrom: EDAAggregateRoot ]) ifFalse: [ self logErrorMessage: (anAggregateClass name , ' is not an aggregate class') andThrow: EDAInvalidClassToCreateTestMessage ].
]

{ #category : #'instance creation' }
EDATestDeleteCommandMessage class >> forClass: anAggregateClass [
	" Constructor for Test Message of delete aggregate command"
	| testMessage |
	testMessage := super forClass: anAggregateClass.
	testMessage commandOrEventClass: EDADeleteAggregateCommand.
	^ testMessage
	


]

{ #category : #'instance creation' }
EDATestDeleteCommandMessage class >> forClass: anAggregateClass fromInstance: aDeleteAggregateCommand [
	" Constructor for Test Message of command, event or deleteAggregateCommand from a command or event instance"
	| testMessage |
	testMessage := self forClass: anAggregateClass.
	(aDeleteAggregateCommand class == EDADeleteAggregateCommand or: [ aDeleteAggregateCommand class inheritsFrom: EDADeleteAggregateCommand ]) ifFalse: [ self logErrorMessage: (aDeleteAggregateCommand name , ' is not a delete aggregate command class') andThrow: EDAInvalidClassToCreateTestMessage ].
	testMessage message: (testMessage asJsonMessageFilledWith: aDeleteAggregateCommand).
	^ testMessage
	


]

{ #category : #'helper - file readers' }
EDATestDeleteCommandMessage class >> readSampleFileFor: anAggregateClass [
	^ self readFile: ((EDADeleteAggregateCommand sampleFilesPathForTestMessage: self) / ('v' , EDADeleteAggregateCommand latestVersion asString) / 'delete' , (self defaultSampleFileNameFor: anAggregateClass))
]

{ #category : #helper }
EDATestDeleteCommandMessage class >> retrieveCommandOrEventOrAggregateClassFor: aCommandOrEvent [
	^ aCommandOrEvent aggregateRootClass
	


]
