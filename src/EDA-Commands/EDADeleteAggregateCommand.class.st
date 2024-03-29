Class {
	#name : #EDADeleteAggregateCommand,
	#superclass : #EDACommand,
	#category : #'EDA-Commands-Commands'
}

{ #category : #accessing }
EDADeleteAggregateCommand class >> aggregateRootClass [
	^ self subclassResponsibility
]

{ #category : #override }
EDADeleteAggregateCommand class >> invalidCommandExceptionClass [
	^ EDAInvalidDeleteAggregateCommandMessage
]

{ #category : #accessing }
EDADeleteAggregateCommand class >> latestVersion [
	^ 2
]

{ #category : #checking }
EDADeleteAggregateCommand >> checkAggregate: anAggregate [
	^ anAggregate defaultCheckNonCreateCommand: self
]

{ #category : #testing }
EDADeleteAggregateCommand >> isDelete [
	^ true
]

{ #category : #helpers }
EDADeleteAggregateCommand >> isForNonExistentAggregate [
	^ false
]
