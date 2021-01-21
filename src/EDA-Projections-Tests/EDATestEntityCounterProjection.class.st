Class {
	#name : #EDATestEntityCounterProjection,
	#superclass : #EDAProjection,
	#instVars : [
		'entityClassName',
		'counter'
	],
	#category : 'EDA-Projections-Tests'
}

{ #category : #'event projection' }
EDATestEntityCounterProjection class >> incrementCounterPerEntity: anEntityClass [
	| projection |
	projection := repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> anEntityClass asString)} asDictionary.
	projection ifNil: [ 
		projection := EDATestEntityCounterProjection withEntityClassName: anEntityClass asString ].
	projection counter: (projection counter + 1).
]

{ #category : #'instance creation' }
EDATestEntityCounterProjection class >> isVoyageRoot [
	^ true
]

{ #category : #'event projection' }
EDATestEntityCounterProjection class >> projectCreatedEvents: anEvent [
	self incrementCounterPerEntity: anEvent class
]

{ #category : #'instance creation' }
EDATestEntityCounterProjection class >> withEntityClassName: anEntityClassName [
	^ self new
		entityClassName: anEntityClassName;
		yourself
]

{ #category : #accessing }
EDATestEntityCounterProjection >> counter [
	counter ifNil: [ counter := 0 ].
	^ counter
]

{ #category : #accessing }
EDATestEntityCounterProjection >> counter: anObject [
	counter := anObject
]

{ #category : #accessing }
EDATestEntityCounterProjection >> entityClassName [
	^ entityClassName
]

{ #category : #accessing }
EDATestEntityCounterProjection >> entityClassName: anObject [
	entityClassName := anObject
]
