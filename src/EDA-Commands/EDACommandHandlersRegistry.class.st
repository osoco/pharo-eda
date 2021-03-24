Class {
	#name : #EDACommandHandlersRegistry,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'handlers'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDACommandHandlersRegistry class >> emptyRegistry [
	^ self new handlers: Dictionary new.
]

{ #category : #'instance creation' }
EDACommandHandlersRegistry class >> withScanner: aCommandHandlersScanner factory: aCommandHandlerFactory andProjectorClass: aClass [
	| handlerAssocs commandClass commandHandler registry handlerMethod |
	registry := self emptyRegistry.
	handlerAssocs := aCommandHandlersScanner allCommandHandlerMethods.
	handlerAssocs
		do: [ :assoc | 
			commandClass := assoc key.
			handlerMethod := assoc value.
			commandHandler := aCommandHandlerFactory
				newFromHandlerMethod: handlerMethod andProjectorClass: aClass.
			registry registerHandler: commandHandler command: commandClass new ].
	^ registry
]

{ #category : #registry }
EDACommandHandlersRegistry >> handlerForCommand: aCommand [
	^ self handlers at: aCommand class ifAbsent: [ nil ]
]

{ #category : #accessing }
EDACommandHandlersRegistry >> handlers [
	^ handlers
]

{ #category : #accessing }
EDACommandHandlersRegistry >> handlers: anObject [
	handlers := anObject
]

{ #category : #registry }
EDACommandHandlersRegistry >> registerHandler: aCommandHandler command: aCommand [
	aCommand ifNil: [ EDACommandError signal ].
	self handlers at: aCommand class put: aCommandHandler
]
