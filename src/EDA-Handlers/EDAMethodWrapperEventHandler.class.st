Class {
	#name : #EDAMethodWrapperEventHandler,
	#superclass : #EDAEventHandler,
	#instVars : [
		'handlerMethod',
		'handler',
		'handlerClass'
	],
	#category : #'EDA-Handlers-Events'
}

{ #category : #'instance creation' }
EDAMethodWrapperEventHandler class >> newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus andProjectorClass: aClass [
	| result |
	result := self
		newFromEventStore: anEventStore
		eventBus: anEventBus
		andProjectorClass: aClass.
	result
		handlerMethod: aMethod.
	^ result
]

{ #category : #handling }
EDAMethodWrapperEventHandler >> delegateHandlingOfEvent: anEvent toAggregate: anAggregateRoot [
	^ self invokeMethodHandlerWith: anEvent on: anAggregateRoot
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handler [
	^ handler
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handler: anObject [
	handler := anObject
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handlerClass [
	^ handlerClass
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handlerClass: anObject [
	handlerClass := anObject
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handlerMethod [
	^ handlerMethod
]

{ #category : #accessing }
EDAMethodWrapperEventHandler >> handlerMethod: anObject [
	handlerMethod := anObject
]
