Class {
	#name : #EDACommandHandlersRegistry,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper + EDACLogging',
	#classTraits : 'EDACPrintOnHelper classTrait + EDACLogging classTrait',
	#instVars : [
		'handlers'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDACommandHandlersRegistry class >> emptyRegistry [
	^ self new handlers: Dictionary new.
]

{ #category : #logging }
EDACommandHandlersRegistry class >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandHandlersRegistry class >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandHandlersRegistry class >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandHandlersRegistry class >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandHandlersRegistry class >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #'instance creation' }
EDACommandHandlersRegistry class >> withScanner: aCommandHandlersScanner factory: aCommandHandlerFactory andProjectorClass: aClass [
	| handlerAssocs commandClass commandHandler registry handlerMethod |
	registry := self emptyRegistry.
	handlerAssocs := aCommandHandlersScanner allCommandHandlerMethods.
	handlerAssocs ifNil: [ self logErrorMessage: 'No handler methods found' andThrow: EDACommandHandlerNotFound ].
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
