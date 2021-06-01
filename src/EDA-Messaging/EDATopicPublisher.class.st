Class {
	#name : #EDATopicPublisher,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#category : 'EDA-Messaging-Topic'
}

{ #category : #lifecycle }
EDATopicPublisher >> close [
	self client close
]

{ #category : #writing }
EDATopicPublisher >> publishMessage: aMessage [
	self subclassResponsibility
]

{ #category : #writing }
EDATopicPublisher >> publishMessage: aMessage inTransaction: transactionId [
	self subclassResponsibility 
]

{ #category : #writing }
EDATopicPublisher >> publishMessage: aMessage withRoutingKey: aRoutingKeyString [
	self subclassResponsibility
]

{ #category : #writing }
EDATopicPublisher >> publishMessagesAtomically: messages [
	self subclassResponsibility
]
