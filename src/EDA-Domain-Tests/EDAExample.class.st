Class {
	#name : #EDAExample,
	#superclass : #Object,
	#instVars : [
		'given',
		'when',
		'then'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #'instance creation' }
EDAExample class >> given: givenObject when: whenObject then: thenObject [
	^ self new
		given: givenObject;
		when: whenObject;
		then: thenObject;
		yourself
]

{ #category : #accessing }
EDAExample >> given [
	^ given
]

{ #category : #accessing }
EDAExample >> given: anObject [
	given := anObject
]

{ #category : #accessing }
EDAExample >> then [
	^ then
]

{ #category : #accessing }
EDAExample >> then: anObject [
	then := anObject
]

{ #category : #accessing }
EDAExample >> when [
	^ when
]

{ #category : #accessing }
EDAExample >> when: anObject [
	when := anObject
]
