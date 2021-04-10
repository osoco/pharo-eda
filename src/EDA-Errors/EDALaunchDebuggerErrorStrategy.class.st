"
Class: EDALaunchDebuggerProjectionErrorHandlingStrategy

This strategy launches the default debugger when an error is detected while projecting events.

Responsibility:

To launch the debugger to help figuring out how to fix bugs.

Collaborators:

The settings framework is responsible to allow the user to choose among the available strategy implementations.

Public API and Key Messages:

See EDAProjectionErrorHandlingStrategy
"
Class {
	#name : #EDALaunchDebuggerErrorStrategy,
	#superclass : #EDAErrorHandlingStrategy,
	#classInstVars : [
		'errors'
	],
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDALaunchDebuggerErrorStrategy class >> annotateError: anError [
	self errors add: anError
]

{ #category : #accessing }
EDALaunchDebuggerErrorStrategy class >> description [
	^ 'Launch debugger'
]

{ #category : #accessing }
EDALaunchDebuggerErrorStrategy class >> errors [
	^ errors
]

{ #category : #accessing }
EDALaunchDebuggerErrorStrategy class >> errors: aCollection [
	errors := aCollection
]

{ #category : #'class initialization' }
EDALaunchDebuggerErrorStrategy class >> initialize [
	self errors: OrderedCollection new
]

{ #category : #'error handling' }
EDALaunchDebuggerErrorStrategy >> handleError: anException withExtraContextInformation: aDictionary [
	anException freeze.
	self class annotateError: anException.
	anException signal.
	^ true
]
