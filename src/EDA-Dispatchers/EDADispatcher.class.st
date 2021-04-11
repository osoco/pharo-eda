Class {
	#name : #EDADispatcher,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'handlersRegistry',
		'eventStore',
		'eventProducer'
	],
	#category : #'EDA-Dispatchers-Dispatchers'
}

{ #category : #dispatching }
EDADispatcher >> dispatch: anObject usingStrategy: aStrategy [
	self subclassResponsibility
]

{ #category : #accessing }
EDADispatcher >> eventProducer [
	^ eventProducer
]

{ #category : #accessing }
EDADispatcher >> eventProducer: anEventProducer [
	eventProducer := anEventProducer
]

{ #category : #accessing }
EDADispatcher >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDADispatcher >> eventStore: anEventStore [
	eventStore := anEventStore
]

{ #category : #accessing }
EDADispatcher >> handlersRegistry [
	^ handlersRegistry 
]

{ #category : #accessing }
EDADispatcher >> handlersRegistry: aHandlersRegistry [
	handlersRegistry  := aHandlersRegistry
]
