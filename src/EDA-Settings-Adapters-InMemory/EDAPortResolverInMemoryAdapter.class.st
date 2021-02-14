Class {
	#name : #EDAPortResolverInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATPortSettingsPort + EDAPrintOnHelper + EDATInMemoryAdapter',
	#classTraits : 'EDATPortSettingsPort classTrait + EDAPrintOnHelper classTrait + EDATInMemoryAdapter classTrait',
	#instVars : [
		'environmentPort',
		'environmentSettingsResolverPort',
		'edaApplication'
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
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPort [
	environmentSettingsResolverPort
		ifNil: [ 
			self environmentSettingsResolverPort: EDAPortResolverByPriorityAdapter new ].
	^ environmentSettingsResolverPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPort: anAdapter [
	anAdapter = environmentSettingsResolverPort
		ifTrue: [ ^ self ].
	self 
		notifyEnvironmentSettingsResolverPortListener: anAdapter.
	environmentSettingsResolverPort := anAdapter
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> notifyEnvironmentSettingsResolverPortListener: anAdapter [
	self edaApplication
		notifyEnvironmentSettingsResolverPortListener: anAdapter
]
