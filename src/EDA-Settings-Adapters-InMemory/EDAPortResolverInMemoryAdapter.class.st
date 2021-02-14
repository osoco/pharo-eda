Class {
	#name : #EDAPortResolverInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDAPortSettingsPort + EDAPrintOnHelper + EDAInMemoryAdapter',
	#classTraits : 'EDAPortSettingsPort classTrait + EDAPrintOnHelper classTrait + EDAInMemoryAdapter classTrait',
	#instVars : [
		'environmentPort',
		'environmentSettingsResolverPort'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentPort [
	^ environmentPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentPort: aPort [
	environmentPort := aPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPort [
	environmentSettingsResolverPort ifNil: [ 
		| result |
		result := EDAPortResolverByPriorityAdapter new.
		self environmentSettingsResolverPort: result ].
	^ environmentSettingsResolverPort
]

{ #category : #accessing }
EDAPortResolverInMemoryAdapter >> environmentSettingsResolverPort: anAdapter [
	environmentSettingsResolverPort := anAdapter
]
