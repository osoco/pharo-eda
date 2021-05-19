Class {
	#name : #EDAPortSettingsPort,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'environmentSettingsPort',
		'environmentSettingsAdapterClass',
		'commandListenerErrorStrategyAdapterClass'
	],
	#category : #'EDA-Settings-Ports'
}

{ #category : #'instance creation' }
EDAPortSettingsPort class >> withAnnouncer: anEDASettingsAnnouncer [
	^ self new announcer: anEDASettingsAnnouncer; yourself
]

{ #category : #accessing }
EDAPortSettingsPort >> announcer [
	^ announcer
]

{ #category : #accessing }
EDAPortSettingsPort >> announcer: anObject [
	announcer := anObject
]

{ #category : #accessing }
EDAPortSettingsPort >> commandListenerErrorStrategyAdapterClass [
	^ commandListenerErrorStrategyAdapterClass
]

{ #category : #accessing }
EDAPortSettingsPort >> commandListenerErrorStrategyAdapterClass: anObject [
	commandListenerErrorStrategyAdapterClass := anObject
]

{ #category : #accessing }
EDAPortSettingsPort >> environmentSettingsAdapterClass [
	^ environmentSettingsAdapterClass
]

{ #category : #accessing }
EDAPortSettingsPort >> environmentSettingsAdapterClass: newValue [
	| oldValue |
	oldValue := environmentSettingsAdapterClass.
	environmentSettingsAdapterClass := newValue.
	oldValue = newValue
		ifFalse: [ self announcer
				announce:
					(EDAEnvironmentSettingsAdapterClassChanged
						old: oldValue
						new: newValue
						on: self announcer edaApplication) ]
]

{ #category : #accessing }
EDAPortSettingsPort >> environmentSettingsPort [
	^ environmentSettingsPort ifNil: [ | result | result := EDAPortResolver new resolveEnvironmentSettingsPort. self environmentSettingsPort: result. result ]
]

{ #category : #accessing }
EDAPortSettingsPort >> environmentSettingsPort: anObject [
	environmentSettingsPort := anObject
]
