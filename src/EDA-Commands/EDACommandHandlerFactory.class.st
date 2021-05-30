Class {
	#name : #EDACommandHandlerFactory,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#instVars : [
		'eventStore',
		'eventBus'
	],
	#category : #'EDA-Commands-Handlers'
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
	^ EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: self eventStore
		eventBus: self eventBus
		andProjectorClass: self projectorClass
]

{ #category : #'as yet unclassified' }
EDACommandHandlerFactory >> newFromHandlerMethod: aMethod andProjectorClass: aProjectorClass [
	^ EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: self eventStore
		eventBus: self eventBus
		andProjectorClass: aProjectorClass
]
