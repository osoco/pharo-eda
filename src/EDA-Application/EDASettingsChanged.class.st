Class {
	#name : #EDASettingsChanged,
	#superclass : #Announcement,
	#instVars : [
		'adapter',
		'edaApplication'
	],
	#category : #'EDA-Application'
}

{ #category : #'instance creation' }
EDASettingsChanged class >> with: anAdapter on: anEDAApplication [
	^ self new
		adapter: anAdapter;
		edaApplication: anEDAApplication;
		yourself
]

{ #category : #accessing }
EDASettingsChanged >> adapter [
	^ adapter
]

{ #category : #accessing }
EDASettingsChanged >> adapter: anAdapter [
	adapter := anAdapter
]

{ #category : #accessing }
EDASettingsChanged >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDASettingsChanged >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication 
]
