Class {
	#name : #EDAThrowError,
	#superclass : #EDAErrorHandlingStrategy,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAThrowError class >> description [
	^ 'Throw error'
]

{ #category : #logging }
EDAThrowError class >> shouldPersistFuel [
	^ false
]

{ #category : #'error handling' }
EDAThrowError >> handleError: error withExtraContextInformation: aDictionary [
	"Handles the error"
	error signal
]
