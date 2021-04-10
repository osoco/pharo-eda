"
Class: EDAErrorAsEventStrategy

This strategy generates and publishes an event when an error is detected when processing a command.

Responsibility:

To produce an event representing the error detected.

Collaborators:

The settings framework is responsible to allow the user to choose among the available strategy implementations.

Public API and Key Messages:

See EDACommandErrorHandlingStrategy
"
Class {
	#name : #EDAPublishMessageErrorStrategy,
	#superclass : #EDAErrorHandlingStrategy,
	#classInstVars : [
		'topicPublisher'
	],
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAPublishMessageErrorStrategy class >> description [
	^ 'Publish an error message'
]

{ #category : #accessing }
EDAPublishMessageErrorStrategy class >> priority [ 
	^ 10
]

{ #category : #accessing }
EDAPublishMessageErrorStrategy class >> topicPublisher [
	^ topicPublisher
]

{ #category : #accessing }
EDAPublishMessageErrorStrategy class >> topicPublisher: aTopicPublisher [
	topicPublisher := aTopicPublisher
]

{ #category : #'error handling' }
EDAPublishMessageErrorStrategy >> handleError: anError withExtraContextInformation: aDictionary [
	| serializer message |
	serializer := EDAJsonErrorSerializer
		withContext: thisContext clone
		andExtraContextInformation: aDictionary.
	message := serializer serialize: anError greaseString.
	EDAEventStompTopicPublisher new publishError: message
]
