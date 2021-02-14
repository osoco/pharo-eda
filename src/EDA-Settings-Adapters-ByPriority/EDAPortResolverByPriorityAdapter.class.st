Class {
	#name : #EDAPortResolverByPriorityAdapter,
	#superclass : #Object,
	#traits : 'EDATPortSettingsPort + EDATByPriorityAdapter',
	#classTraits : 'EDATPortSettingsPort classTrait + EDATByPriorityAdapter classTrait',
	#instVars : [
		'edaApplication'
	],
	#category : #'EDA-Settings-Adapters-ByPriority'
}

{ #category : #testing }
EDAPortResolverByPriorityAdapter class >> description [
	^ 'Priority-based'
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableCommandListenerSettingsAdapters [
	^ self availableAdapters: EDATCommandListenerSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEnvironmentSettingsAdapters [
	^ self availableAdapters: EDATEnvironmentSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEventPublisherSettingsAdapters [
	^ self availableAdapters: EDATEventPublisherSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEventStoreSettingsAdapters [
	^ self availableAdapters: EDATEventStoreSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableLoggingSettingsAdapters [
	^ self availableAdapters: EDATLoggingSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableProjectionSettingsAdapters [
	^ self availableAdapters: EDATProjectionSettingsPort
]

{ #category : #accessing }
EDAPortResolverByPriorityAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAPortResolverByPriorityAdapter >> edaApplication: anEDAApplication [ 
 edaApplication := anEDAApplication 
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveCommandListenerSettingsPort [
	^ self resolveSettingsPort: EDATCommandListenerSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEnvironmentSettingsPort [
	^ self resolveSettingsPort: EDATEnvironmentSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventPublisherSettingsPort [
	^ self resolveSettingsPort: EDATEventPublisherSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventStoreSettingsPort [
	^ self resolveSettingsPort: EDATEventStoreSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveLoggingSettingsPort [
	^ self resolveSettingsPort: EDATLoggingSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveProjectionSettingsPort [
	^ self resolveSettingsPort: EDATProjectionSettingsPort
]
