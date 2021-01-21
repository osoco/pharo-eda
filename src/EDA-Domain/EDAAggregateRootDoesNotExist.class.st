Class {
	#name : #EDAAggregateRootDoesNotExist,
	#superclass : #EDADomainException,
	#instVars : [
		'aggregateRootClass'
	],
	#category : 'EDA-Domain-Exceptions'
}

{ #category : #'instance creation' }
EDAAggregateRootDoesNotExist class >> forClass: aClass [
	| result |
	result := EDAAggregateRootDoesNotExist new.
	result aggregateRootClass: aClass.
	^ result
]

{ #category : #accessing }
EDAAggregateRootDoesNotExist >> aggregateRootClass [
	^ aggregateRootClass
]

{ #category : #accessing }
EDAAggregateRootDoesNotExist >> aggregateRootClass: aClass [
	aggregateRootClass := aClass
]
