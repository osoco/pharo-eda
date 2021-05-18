Class {
	#name : #EDASettingsChanged,
	#superclass : #Announcement,
	#instVars : [
		'oldValue',
		'newValue',
		'edaApplication'
	],
	#category : #'EDA-Application'
}

{ #category : #'instance creation' }
EDASettingsChanged class >> old: anOldValue new: aNewValue on: anEDAApplication [
	^ self new
		oldValue: anOldValue;
		newValue: aNewValue;
		edaApplication: anEDAApplication;
		yourself
]

{ #category : #accessing }
EDASettingsChanged >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDASettingsChanged >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication 
]

{ #category : #accessing }
EDASettingsChanged >> newValue [
	^ newValue
]

{ #category : #accessing }
EDASettingsChanged >> newValue: anObject [
	newValue := anObject
]

{ #category : #accessing }
EDASettingsChanged >> oldValue [
	^ oldValue
]

{ #category : #accessing }
EDASettingsChanged >> oldValue: anObject [
	oldValue := anObject
]
