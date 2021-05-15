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
	^ self resolvePort: EDATCommandListenerSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEnvironmentSettingsPort [
	^ self resolvePort: EDATEnvironmentSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventPublisherSettingsPort [
	^ self resolvePort: EDATEventPublisherSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventStoreSettingsPort [
	^ self resolvePort: EDATEventStoreSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveLoggingSettingsPort [
	^ self resolvePort: EDATLoggingSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveProjectionSettingsPort [
	^ self resolvePort: EDATProjectionSettingsPort
]
