Class {
	#name : #EDAThrowError,
	#superclass : #EDAErrorHandlingStrategy,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Errors-Strategies'
}

{ #category : #logging }
EDAThrowError class >> shouldPersistFuel [
	^ false
]

{ #category : #accessing }
EDAThrowError >> description [
	^ 'Throw error'
]

{ #category : #'error handling' }
EDAThrowError >> handleError: error withExtraContextInformation: aDictionary [
	"Handles the error"
	error signal
]
