Class {
	#name : #EDACommandHandlerFactory,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'eventStore',
		'eventBus'
	],
	#category : 'EDA-Commands-Handlers'
}

{ #category : #factory }
EDACommandHandlerFactory class >> factoryWithEventStore: anEventStore eventBus: anEventBus [
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		yourself
]

{ #category : #accessing }
EDACommandHandlerFactory >> eventBus [
	^ eventBus
]

{ #category : #accessing }
EDACommandHandlerFactory >> eventBus: anObject [
	eventBus := anObject
]

{ #category : #accessing }
EDACommandHandlerFactory >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDACommandHandlerFactory >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #factory }
EDACommandHandlerFactory >> newFromHandlerMethod: aMethod [
	^ EDAMethodWrapperCommandHandler newFromHandlerMethod: aMethod eventStore: self eventStore eventBus: self eventBus 
]
