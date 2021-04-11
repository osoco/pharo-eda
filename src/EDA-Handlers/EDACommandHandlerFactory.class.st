Class {
	#name : #EDACommandHandlerFactory,
	#superclass : #Object,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'eventStore',
		'eventBus'
	],
	#category : #'EDA-Handlers-Commands'
}

{ #category : #'instance creation' }
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
EDACommandHandlerFactory >> newFromHandlerMethod: aMethod andProjectorClass: aProjectorClass [
	^ EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: self eventStore
		eventBus: self eventBus
		andProjectorClass: aProjectorClass
]
