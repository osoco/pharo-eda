Class {
	#name : #EDAMethodWrapperCommandHandler,
	#superclass : #EDACommandHandler,
	#instVars : [
		'handlerMethod',
		'aggregateRoot',
		'aggregateRootClass'
	],
	#category : 'EDA-Commands-Handlers'
}

{ #category : #factory }
EDAMethodWrapperCommandHandler class >> newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus [
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		handlerMethod: aMethod;
		aggregateRootClass: aMethod methodClass;
		yourself
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
	aCommand isCreate
		ifTrue: [ anAggregateRoot class checkTenantOfCommandIsValid: aCommand ]
		ifFalse: [ anAggregateRoot class
				checkTenantOfCommand: aCommand tenant
				matches: anAggregateRoot tenant ].
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

{ #category : #handling }
EDAMethodWrapperCommandHandler >> invokeMethodHandlerWith: aCommand on: aReceiver [
	self
		logDebugMessage: (String streamContents: [ :s | s nextPutAll: 'Handling command '; nextPutAll: aCommand class greaseString ]).
	^ aReceiver perform: self handlerMethod selector with: aCommand
]

{ #category : #helper }
EDAMethodWrapperCommandHandler >> retrieveAggregateRootClass: aCommand [
	^ self aggregateRootClass
]