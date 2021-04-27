Class {
	#name : #EDAUserCommand,
	#superclass : #EDACommand,
	#instVars : [
		'authorUsername'
	],
	#category : #'EDA-Domain-Commands'
}

{ #category : #accessing }
EDAUserCommand >> authorUsername [
	^ authorUsername
]

{ #category : #accessing }
EDAUserCommand >> authorUsername: anObject [
	authorUsername := anObject
]

{ #category : #helpers }
EDAUserCommand >> fillCommonInfoInto: aDict [
	super fillCommonInfoInto: aDict.
	aDict at: #authorUsername put: self authorUsername.

]
