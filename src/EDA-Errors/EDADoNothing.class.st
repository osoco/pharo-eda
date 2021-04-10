Class {
	#name : #EDADoNothing,
	#superclass : #EDAErrorHandlingStrategy,
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDADoNothing class >> description [
	^ 'Do nothing'
]

{ #category : #'error handling' }
EDADoNothing >> handleError: anException withExtraContextInformation: aDictionary [
	^ false
]
