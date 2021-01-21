Class {
	#name : #EDAUserCommandResultEvent,
	#superclass : #EDACommandResultEvent,
	#instVars : [
		'authorUsername'
	],
	#category : 'EDA-Events-Events'
}

{ #category : #accessing }
EDAUserCommandResultEvent >> authorUsername [
	^ authorUsername
]

{ #category : #accessing }
EDAUserCommandResultEvent >> authorUsername: anObject [
	authorUsername := anObject
]
