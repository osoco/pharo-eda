Class {
	#name : #EDACommandResultEvent,
	#superclass : #EDAEventSourcingEvent,
	#instVars : [
		'commandId'
	],
	#category : #'EDA-Events-Events'
}

{ #category : #accessing }
EDACommandResultEvent >> commandId [
	^ commandId
]

{ #category : #accessing }
EDACommandResultEvent >> commandId: anObject [
	commandId := anObject
]

{ #category : #accessing }
EDACommandResultEvent >> correlationId [
	^ self commandId
]
