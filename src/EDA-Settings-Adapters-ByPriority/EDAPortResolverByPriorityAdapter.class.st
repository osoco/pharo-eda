Class {
	#name : #EDAPortResolverByPriorityAdapter,
	#superclass : #Object,
	#traits : 'EDAPortSettingsPort + EDAByPriorityAdapter',
	#classTraits : 'EDAPortSettingsPort classTrait + EDAByPriorityAdapter classTrait',
	#category : #'EDA-Settings-Adapters-ByPriority'
}

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableCommandListenerSettingsAdapters [
	^ self availableAdapters: EDACommandListenerSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEnvironmentSettingsAdapters [
	^ self availableAdapters: EDAEnvironmentSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEventPublisherSettingsAdapters [
	^ self availableAdapters: EDAEventPublisherSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableEventStoreSettingsAdapters [
	^ self availableAdapters: EDAEventStoreSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableLoggingSettingsAdapters [
	^ self availableAdapters: EDALoggingSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> availableProjectionSettingsAdapters [
	^ self availableAdapters: EDAProjectionSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveCommandListenerSettingsPort [
	^ self resolveSettingsPort: EDACommandListenerSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEnvironmentSettingsPort [
	^ self resolveSettingsPort: EDAEnvironmentSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventPublisherSettingsPort [
	^ self resolveSettingsPort: EDAEventPublisherSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveEventStoreSettingsPort [
	^ self resolveSettingsPort: EDAEventStoreSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveLoggingSettingsPort [
	^ self resolveSettingsPort: EDALoggingSettingsPort
]

{ #category : #logic }
EDAPortResolverByPriorityAdapter >> resolveProjectionSettingsPort [
	^ self resolveSettingsPort: EDAProjectionSettingsPort
]
