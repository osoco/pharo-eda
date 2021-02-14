Class {
	#name : #EDAEnvironmentSettingsResolverPortChanged,
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
EDAEnvironmentSettingsResolverPortChanged >> adapter [
	^ adapter
]

{ #category : #accessing }
EDAEnvironmentSettingsResolverPortChanged >> adapter: anAdapter [
	adapter := anAdapter
]

{ #category : #accessing }
EDAEnvironmentSettingsResolverPortChanged >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAEnvironmentSettingsResolverPortChanged >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication 
]
