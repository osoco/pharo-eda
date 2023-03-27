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

{ #category : #accessing }
EDAThrowError >> description [
	^ self class description
]

{ #category : #'error handling' }
EDAThrowError >> handleError: error withExtraContextInformation: aDictionary [
	"Handles the error"
	error signal
]
