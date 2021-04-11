Class {
	#name : #EDAEventHandlersRegistry,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'handlers'
	],
	#category : #'EDA-Handlers-Events'
}

{ #category : #'instance creation' }
EDAEventHandlersRegistry class >> emptyRegistry [
	^ self new handlers: Dictionary new
]

{ #category : #'instance creation' }
EDAEventHandlersRegistry class >> withScanner: anEventHandlersScanner factory: anEventHandlerFactory andProjectorClass: aClass [
	| handlerAssocs registry |
	registry := self emptyRegistry.
	handlerAssocs := anEventHandlersScanner allHandlerMethods.
	handlerAssocs
		ifNil: [ self
				logErrorMessage: 'No handler methods found'
				andThrow: EDAEventHandlerNotFound ].
	handlerAssocs
		do: [ :assoc | | eventClass handlerMethod eventHandler |
			eventClass := assoc key.
			handlerMethod := assoc value.
			eventHandler := anEventHandlerFactory
				newFromHandlerMethod: handlerMethod
				andProjectorClass: aClass.
			registry registerHandler: eventHandler event: eventClass new ].
	^ registry
]

{ #category : #registry }
EDAEventHandlersRegistry >> handlerForEvent: anEvent [
	^ self handlers at: anEvent class ifAbsent: [ nil ]
]

{ #category : #accessing }
EDAEventHandlersRegistry >> handlers [
	^ handlers
]

{ #category : #accessing }
EDAEventHandlersRegistry >> handlers: anObject [
	handlers := anObject
]

{ #category : #registry }
EDAEventHandlersRegistry >> registerHandler: anEventHandler event: anEvent [
	anEvent ifNil: [ EDAEventError signal ].
	self handlers at: anEvent class put: anEventHandler
]
