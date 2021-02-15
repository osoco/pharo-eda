Class {
	#name : #EDAApplicationRegistered,
	#superclass : #Announcement,
	#instVars : [
		'edaApplication'
	],
	#category : #'EDA-Application'
}

{ #category : #'instance creation' }
EDAApplicationRegistered class >> on: anEDAApplication [
	^ self new edaApplication: anEDAApplication; yourself
]

{ #category : #accessing }
EDAApplicationRegistered >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAApplicationRegistered >> edaApplication: anEDAApplication [ 
	edaApplication := anEDAApplication 
]
