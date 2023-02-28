Class {
	#name : #EDAEventProducerPublishing,
	#superclass : #EDAEventProducer,
	#instVars : [
		'serializer',
		'publisher'
	],
	#category : #'EDA-Messaging-Event'
}

{ #category : #'instance creation' }
EDAEventProducerPublishing class >> forEDAApplication: anEDAApplication [
	^ anEDAApplication createEventProducerPublishing: self
]

{ #category : #helpers }
EDAEventProducerPublishing class >> routingKey: anEvent [
	^ anEvent routingKey
]

{ #category : #'instance creation' }
EDAEventProducerPublishing class >> withEventAnnouncer: anAnnouncer publisher: publisher andSerializer: serializer [
	^ (self
		withEventAnnouncer: anAnnouncer)
			publisher: publisher;
			serializer: serializer;
			yourself
]

{ #category : #lifecycle }
EDAEventProducerPublishing >> close [
	super close.
	publisher close
]

{ #category : #testing }
EDAEventProducerPublishing >> isHealthy [
	^ publisher isHealthy
]

{ #category : #accessing }
EDAEventProducerPublishing >> produceEvent: anEvent [
	| message routingKey |
	message := serializer serialize: anEvent.
	routingKey := self class routingKey: anEvent.
	routingKey
		ifNotNil:
			[ :arg | publisher publishMessage: message withRoutingKey: routingKey ]
		ifNil: [ publisher publishMessage: message ].
	self announce: anEvent
]

{ #category : #accessing }
EDAEventProducerPublishing >> publisher: anObject [
	publisher := anObject
]

{ #category : #accessing }
EDAEventProducerPublishing >> serializer: anObject [
	serializer := anObject
]
