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
EDAThrowError >> doHandleError: anException withExtraContextInformation: anExtraContextInformationDict [
	"Handles the error"

	anException signal
]
