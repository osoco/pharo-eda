Class {
	#name : #EDAEnvironmentSettingsPortChanged,
	#superclass : #Announcement,
	#traits : 'EDATSettingsChanged',
	#classTraits : 'EDATSettingsChanged classTrait',
	#instVars : [
		'adapter',
		'edaApplication'
	],
	#category : #'EDA-Application'
}

{ #category : #accessing }
EDAEnvironmentSettingsPortChanged >> adapter [
	^ adapter
]

{ #category : #accessing }
EDAEnvironmentSettingsPortChanged >> adapter: anAdapter [
	adapter := anAdapter 
]

{ #category : #accessing }
EDAEnvironmentSettingsPortChanged >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAEnvironmentSettingsPortChanged >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]
