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
EDAEventHandlersRegistry class >> withScanner: aCommandHandlersScanner factory: aCommandHandlerFactory andProjectorClass: aClass [
	| handlerAssocs commandClass commandHandler registry handlerMethod |
	registry := self emptyRegistry.
	handlerAssocs := aCommandHandlersScanner allHandlerMethods.
	handlerAssocs
		ifNil: [ self
				logErrorMessage: 'No handler methods found'
				andThrow: EDAEventHandlerNotFound ].
	handlerAssocs
		do: [ :assoc | 
			commandClass := assoc key.
			handlerMethod := assoc value.
			commandHandler := aCommandHandlerFactory
				newFromHandlerMethod: handlerMethod
				andProjectorClass: aClass.
			registry registerHandler: commandHandler command: commandClass new ].
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
