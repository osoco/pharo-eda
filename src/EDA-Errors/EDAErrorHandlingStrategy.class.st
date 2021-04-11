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
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'context'
	],
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAErrorHandlingStrategy class >> description [
	"The strategy description"
	self subclassResponsibility.
	^ self
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> priority [ 
	^ 100
]

{ #category : #accessing }
EDAErrorHandlingStrategy class >> shouldPersistFuel [
	^ true
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
	^ self class description
]

{ #category : #'error handling' }
EDAErrorHandlingStrategy >> handleError: anException withExtraContextInformation: aDictionary [
	self subclassResponsibility
]
