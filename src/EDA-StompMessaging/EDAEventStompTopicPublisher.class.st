"
Class: EDAEventStompTopicPublisher

Customization of EDAStompTopicPublisher, for publishing events to other services.

Responsibility:

It's used to publish events reflecting changes in aggregate roots upon receiving input commands.
"
Class {
	#name : #EDAEventStompTopicPublisher,
	#superclass : #EDAStompTopicPublisher,
	#category : 'EDA-StompMessaging'
}

{ #category : #API }
EDAEventStompTopicPublisher >> publishEvent: anEvent [
	^ self publishMessage: anEvent
]

{ #category : #API }
EDAEventStompTopicPublisher >> publishEvent: anEvent inTransaction: id [
	^ self publishMessage: anEvent inTransaction: id

]

{ #category : #API }
EDAEventStompTopicPublisher >> publishEvent: anEvent withRoutingKey: route [
	^ self publishMessage: anEvent withRoutingKey: route

]

{ #category : #API }
EDAEventStompTopicPublisher >> publishEventsAtomically: eventCollection [
	^ self publishMessagesAtomically: eventCollection
]
