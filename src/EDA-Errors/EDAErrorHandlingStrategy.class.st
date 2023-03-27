"
Class: EDACommandHandlerErrorHandlingStrategy

This class represents a concrete strategy when dealing with errors detected when processing input commands.

Responsibility:

Any strategy must extend this class and implement #handleError:.

Collaborators:

A EDAAggregateRoot that is accepting input commands should react upon errors by retrieving the selected strategy and delegating the error to it.
The Settings framework allows the user to review and choose among all defined strategies.

Public API and Key Messages:

- handleError: to deal with the error itself.
- description (class side): to describe the main purpose of the strategy.

"
Class {
	#name : #EDAErrorHandlingStrategy,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'context'
	],
	#classVars : [
		'shouldNotifyByDiscordPersistedFuel',
		'shouldPersistFuel'
	],
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAErrorHandlingStrategy class >> description [
	"The strategy description"
	self subclassResponsibility.
	^ self
]

{ #category : #'notification helpers' }
EDAErrorHandlingStrategy class >> messageForExtraContextInformation: extraContextInformationDict [
	extraContextInformationDict
		at: #message
		ifPresent: [ :message | ^ message ].
	extraContextInformationDict
		at: #command
		ifPresent: [ :command | ^ command ].
	extraContextInformationDict
		at: #event
		ifPresent: [ :event | ^ event ].
	extraContextInformationDict ifEmpty: [ ^ nil ].
	^ nil
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> priority [ 
	^ 100
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> shouldNotifyByDiscordPersistedFuel [
	^ shouldNotifyByDiscordPersistedFuel
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> shouldNotifyByDiscordPersistedFuel: anObject [
	shouldNotifyByDiscordPersistedFuel := anObject
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> shouldPersistFuel [
	^ shouldPersistFuel
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> shouldPersistFuel: aBoolean [
	shouldPersistFuel := aBoolean
]

{ #category : #'notification helpers' }
EDAErrorHandlingStrategy class >> titleForExtraContextInformation: extraContextInformationDict [
	extraContextInformationDict
		at: #message
		ifPresent: [ :message | ^ 'Error processing message' ].
	extraContextInformationDict
		at: #command
		ifPresent: [ :command | 
			^ 'Error processing command ' , command class name , ' for tenant '
				, command tenant ].
	extraContextInformationDict
		at: #event
		ifPresent: [ :event | ^ 'Error projecting an event' ].
	extraContextInformationDict ifEmpty: [ ^ 'Error detected' ].
	^ 'Error detected'
]

{ #category : #accessing }
EDAErrorHandlingStrategy >> context [
	"Retrieves the context"
	^ context
]

{ #category : #accessing }
EDAErrorHandlingStrategy >> context: ctx [
	"Specifies the context"
	context := ctx
]

{ #category : #accessing }
EDAErrorHandlingStrategy >> description [
	"The strategy description"
	self subclassResponsibility.
	^ self
]

{ #category : #'error handling' }
EDAErrorHandlingStrategy >> doHandleError: anException withExtraContextInformation: anExtraContextInformationDict [
	^ self subclassResponsibility
]

{ #category : #'error handling' }
EDAErrorHandlingStrategy >> handleContextForException: anException withExtraContextInformation: extraContextInformationDict [
	| basename fuelContextFileReference |
	self class shouldPersistFuel
		ifFalse: [ ^ self ].
	basename := self class basename.
	fuelContextFileReference := self
		writeFuelContext: context
		named: anException class greaseString
		withBasename: basename.
	extraContextInformationDict
		at: #command
		ifPresent: [ :command | self writeCommand: command withBasename: basename ].
	extraContextInformationDict
		at: #event
		ifPresent: [ :event | self writeEvent: event withBasename: basename ].
	extraContextInformationDict
		at: #message
		ifPresent: [ :message | self writeMessage: message withBasename: basename ].
	self class shouldNotifyByDiscordPersistedFuel
		ifFalse: [ ^ self ].
	self
		notify: anException
		withExtraContextInformation: extraContextInformationDict
		andFuelContext: fuelContextFileReference.
]

{ #category : #'error handling' }
EDAErrorHandlingStrategy >> handleError: anException withExtraContextInformation: anExtraContextInformationDict [
	"Handles the error"

	self
		handleContextForException: anException
		withExtraContextInformation: anExtraContextInformationDict.
	^ self doHandleError: anException withExtraContextInformation: anExtraContextInformationDict
]

{ #category : #'error handling' }
EDAErrorHandlingStrategy >> notify: anException withExtraContextInformation: extraContextInformationDict andFuelContext: fuelContextFileReference [
	| title message |
	title := self class titleForExtraContextInformation: extraContextInformationDict.
	message := self class messageForExtraContextInformation: extraContextInformationDict.
	self
		notifyError: anException
		withTitle: title
		andProcessingMessage: message
		andFuelContext: fuelContextFileReference
]
