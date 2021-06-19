Class {
	#name : #EDAAlreadyExistingAggregate,
	#superclass : #EDADomainException,
	#category : #'EDA-Domain-Exceptions'
}

{ #category : #checking }
EDAAlreadyExistingAggregate class >> exceptionForAggregateRootClass: anAggregateRootClass [
	self subclassResponsibility
]
