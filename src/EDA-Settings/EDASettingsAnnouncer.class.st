Class {
	#name : #EDASettingsAnnouncer,
	#superclass : #Announcer,
	#instVars : [
		'edaApplication'
	],
	#category : #'EDA-Settings'
}

{ #category : #'instance creation' }
EDASettingsAnnouncer class >> forApp: anEDAApplication [
	^ self new
		edaApplication: anEDAApplication;
		yourself
]

{ #category : #accessing }
EDASettingsAnnouncer >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDASettingsAnnouncer >> edaApplication: anObject [
	edaApplication := anObject
]

{ #category : #initialization }
EDASettingsAnnouncer >> initialize [
	super initialize.
	self setupListeners
]

{ #category : #initialization }
EDASettingsAnnouncer >> setupListeners [
	EDATSettingsChangedListener traitUsers
		do: [ :l | l subscribeToSettingsChangedEventsIn: self ]
]
