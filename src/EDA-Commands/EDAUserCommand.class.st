Class {
	#name : #EDAUserCommand,
	#superclass : #EDACommand,
	#instVars : [
		'authorUsername'
	],
	#category : 'EDA-Commands-Commands'
}

{ #category : #accessing }
EDAUserCommand >> authorUsername [
	^ authorUsername
]

{ #category : #accessing }
EDAUserCommand >> authorUsername: anObject [
	authorUsername := anObject
]
