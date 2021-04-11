Class {
	#name : #EDAEventHandlerFactory,
	#superclass : #Object,
	#instVars : [
		'eventStore',
		'eventBus'
	],
	#category : #'EDA-Handlers-Events'
}

{ #category : #'instance creation' }
EDAEventHandlerFactory class >> factoryWithEventStore: anEventStore eventBus: anEventBus [
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		yourself
]

{ #category : #accessing }
EDAEventHandlerFactory >> eventBus [
	^ eventBus
]

{ #category : #accessing }
EDAEventHandlerFactory >> eventBus: anObject [
	eventBus := anObject
]

{ #category : #accessing }
EDAEventHandlerFactory >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAEventHandlerFactory >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #'instance creation' }
EDAEventHandlerFactory >> newFromHandlerMethod: aMethod andProjectorClass: aProjectorClass [
	^ EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: self eventStore
		eventBus: self eventBus
		andProjectorClass: aProjectorClass
]
