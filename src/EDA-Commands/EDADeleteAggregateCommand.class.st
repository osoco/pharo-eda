Class {
	#name : #EDADeleteAggregateCommand,
	#superclass : #EDACommand,
	#category : 'EDA-Commands-Commands'
}

{ #category : #accessing }
EDADeleteAggregateCommand class >> aggregateRootClass [
	^ self subclassResponsibility
]

{ #category : #testing }
EDADeleteAggregateCommand >> isDelete [
	^ true
]
