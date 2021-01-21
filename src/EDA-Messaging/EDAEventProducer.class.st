Class {
	#name : #EDAEventProducer,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'serializer',
		'publisher',
		'announcer'
	],
	#category : 'EDA-Messaging-Event'
}

{ #category : #'instance creation' }
EDAEventProducer class >> publisher: publisher serializer: serializer announcer: anAnnouncer [
	^ self new
		publisher: publisher;
		serializer: serializer;
		announcer: anAnnouncer;
		yourself
]

{ #category : #helpers }
EDAEventProducer class >> routingKey: anEvent [
	^ anEvent routingKey
]

{ #category : #accessing }
EDAEventProducer >> announcer [
	^ announcer
]

{ #category : #accessing }
EDAEventProducer >> announcer: anObject [
	announcer := anObject
]

{ #category : #lifecycle }
EDAEventProducer >> close [
	self publisher close
]

{ #category : #helpers }
EDAEventProducer >> printOn: t1 [
	| t2 |
	t2 := ''.
	self class allInstVarNames
		do: [ :t4 | 
			t2 isEmpty
				ifTrue: [ t2 := '{ ' ]
				ifFalse: [ t2 := t2 , ', ' ].
			t2 := t2 , '"' , t4 , '": "' , (self instVarNamed: t4) asString , '"' ].
	t2 := t2 , ' }'.
	t1 nextPutAll: t2.
	^ self
]

{ #category : #accessing }
EDAEventProducer >> produceEvent: anEvent [
	| message routingKey |
	message := self serializer serialize: anEvent.
	routingKey := self class routingKey: anEvent.
	routingKey
		ifNotNil: [ :arg | self publisher publishMessage: message withRoutingKey: routingKey ]
		ifNil: [ self publisher publishMessage: message ].
	(anEvent class inheritsFrom: Announcement)
		ifTrue: [ self announcer announce: anEvent ]
]

{ #category : #accessing }
EDAEventProducer >> produceEvents: anEventCollection [
	anEventCollection ifNotNil: [ anEventCollection do: [ :event | self produceEvent: event ]]
]

{ #category : #accessing }
EDAEventProducer >> publisher [
	^ publisher
]

{ #category : #accessing }
EDAEventProducer >> publisher: anObject [
	publisher := anObject
]

{ #category : #accessing }
EDAEventProducer >> serializer [
	^ serializer
]

{ #category : #accessing }
EDAEventProducer >> serializer: anObject [
	serializer := anObject
]
