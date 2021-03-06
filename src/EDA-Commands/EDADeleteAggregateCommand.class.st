Class {
	#name : #EDADeleteAggregateCommand,
	#superclass : #EDACommand,
	#category : #'EDA-Commands-Commands'
}

{ #category : #accessing }
EDADeleteAggregateCommand class >> aggregateRootClass [
	^ self subclassResponsibility
]

{ #category : #helpers }
EDADeleteAggregateCommand >> isCreate [
	^ false
]

{ #category : #testing }
EDADeleteAggregateCommand >> isDelete [
	^ true
]
