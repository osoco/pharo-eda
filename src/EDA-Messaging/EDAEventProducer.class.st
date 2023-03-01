Class {
	#name : #EDAEventProducer,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'EDA-Messaging-EventProducer-Strategies'
}

{ #category : #helpers }
EDAEventProducer class >> description [
	^ 'Announce Event'
]

{ #category : #'instance creation' }
EDAEventProducer class >> forEDAApplication: anEDAApplication [
	^ anEDAApplication createEventProducer: self
]

{ #category : #'instance creation' }
EDAEventProducer class >> withEventAnnouncer: anAnnouncer [
	^ self new
		announcer: anAnnouncer;
		yourself
]

{ #category : #accessing }
EDAEventProducer >> announce: anEvent [
	(anEvent class inheritsFrom: Announcement)
		ifTrue: [ announcer announce: anEvent ]
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
	announcer := nil
	
]

{ #category : #testing }
EDAEventProducer >> isHealthy [
	^ true
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
	self announce: anEvent
]

{ #category : #accessing }
EDAEventProducer >> produceEvents: anEventCollection [
	anEventCollection ifNotNil: [ anEventCollection do: [ :event | self produceEvent: event ] ]
]
