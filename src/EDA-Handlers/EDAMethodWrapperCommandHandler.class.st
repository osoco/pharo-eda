Class {
	#name : #EDAMethodWrapperCommandHandler,
	#superclass : #EDACommandHandler,
	#instVars : [
		'handlerMethod',
		'aggregateRoot',
		'aggregateRootClass'
	],
	#category : #'EDA-Handlers-Commands'
}

{ #category : #'instance creation' }
EDAMethodWrapperCommandHandler class >> newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus andProjectorClass: aClass [
	| result |
	result :=  self newFromEventStore: anEventStore
		eventBus: anEventBus
		andProjectorClass: aClass.
		result
		handlerMethod: aMethod;
		aggregateRootClass: aMethod methodClass.
		^ result
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> aggregateRoot [
	^ aggregateRoot
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> aggregateRoot: anObject [
	aggregateRoot := anObject
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> aggregateRootClass [
	^ aggregateRootClass
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> aggregateRootClass: aClass [
	aggregateRootClass := aClass
]

{ #category : #handling }
EDAMethodWrapperCommandHandler >> delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot [
	anAggregateRoot class checkTenantOfCommandIsValid: aCommand.
	aCommand isCreate ifNotNil: [ :isCreate |
		isCreate 
			ifFalse: [ anAggregateRoot class
				checkTenantOfCommand: aCommand tenant
				matches: anAggregateRoot tenant ] ].
	^ self invokeMethodHandlerWith: aCommand on: anAggregateRoot
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> handlerMethod [
	^ handlerMethod
]

{ #category : #accessing }
EDAMethodWrapperCommandHandler >> handlerMethod: anObject [
	handlerMethod := anObject
]

{ #category : #helper }
EDAMethodWrapperCommandHandler >> retrieveAggregateRootClass: aCommand [
	^ self aggregateRootClass
]
