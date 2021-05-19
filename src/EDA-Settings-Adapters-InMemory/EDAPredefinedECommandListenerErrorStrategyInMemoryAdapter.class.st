Class {
	#name : #EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDATCommandListenerSettingsErrorStrategyPort',
	#classTraits : 'EDATCommandListenerSettingsErrorStrategyPort classTrait',
	#instVars : [
		'strategy'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter class >> accepts: aPortResolver [
	^ true
]

{ #category : #resolving }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter class >> availableStrategies [
	^ EDAErrorHandlingStrategy subclasses
]

{ #category : #testing }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter class >> description [
	^ 'Predefined list'
]

{ #category : #resolving }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter >> availableStrategies [
	^ self class availableStrategies 
]

{ #category : #accessing }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter >> strategy [
	^ strategy ifNil: [ self strategy: self availableStrategies first. strategy ]
]

{ #category : #accessing }
EDAPredefinedECommandListenerErrorStrategyInMemoryAdapter >> strategy: anObject [
	strategy := anObject
]
