Class {
	#name : #EDADeleteAggregateCommand,
	#superclass : #EDACommand,
	#category : #'EDA-Domain-Commands'
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

{ #category : #helpers }
EDADeleteAggregateCommand >> isCreate [
	^ false
]

{ #category : #testing }
EDADeleteAggregateCommand >> isDelete [
	^ true
]
