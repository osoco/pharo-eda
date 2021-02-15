Class {
	#name : #EDAPortResolverInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATPortSettingsPort + EDAPrintOnHelper + EDATInMemoryAdapter',
	#classTraits : 'EDATPortSettingsPort classTrait + EDAPrintOnHelper classTrait + EDATInMemoryAdapter classTrait',
	#instVars : [
		'environmentSettingsResolverPort',
		'edaApplication',
		'environmentSettingsResolverPortClass',
		'eventStoreSettingsResolverPortClass'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> edaApplication: anEDAApplication [ 
	edaApplication := anEDAApplication 
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsPort [
	^ self environmentSettingsResolverPort resolveEnvironmentSettingsPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPort [
	^ self environmentSettingsResolverPortClass withApp: (self edaApplication)
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPortClass [
	environmentSettingsResolverPortClass
		ifNil: [ 
			self environmentSettingsResolverPortClass: EDAPortResolverByPriorityAdapter ].
	^ environmentSettingsResolverPortClass
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPortClass: anAdapterClass [
	anAdapterClass = environmentSettingsResolverPortClass
		ifTrue: [ ^ self ].
	environmentSettingsResolverPortClass := anAdapterClass.
	self
		notifyEnvironmentSettingsResolverPortListener: self environmentSettingsPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> eventStoreSettingsPort [
	^ self eventStoreSettingsResolverPort resolveEventStoreSettingsPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> eventStoreSettingsResolverPort [
	^ self eventStoreSettingsResolverPortClass
		withApp: self edaApplication
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> eventStoreSettingsResolverPortClass [
	eventStoreSettingsResolverPortClass
		ifNil: [ self
				eventStoreSettingsResolverPortClass: EDAPortResolverByPriorityAdapter ].
	^ eventStoreSettingsResolverPortClass
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> eventStoreSettingsResolverPortClass: anAdapterClass [
	anAdapterClass = eventStoreSettingsResolverPortClass
		ifTrue: [ ^ self ].
	eventStoreSettingsResolverPortClass := anAdapterClass.
	self
		notifyEventStoreSettingsResolverPortListener: self eventStoreSettingsPort
]

{ #category : #testing }
EDAPortResolverInMemoryAdapter >> isReadOnly [
	^ false
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> notifyEnvironmentSettingsResolverPortListener: anAdapter [
	self edaApplication
		notifyEnvironmentSettingsResolverPortListener: anAdapter
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> notifyEventStoreSettingsResolverPortListener: anAdapter [
	self edaApplication
		notifyEventStoreSettingsResolverPortListener: anAdapter
]
