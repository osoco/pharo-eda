Class {
	#name : #EDATopicListener,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : 'EDA-Messaging-Topic'
}

{ #category : #reading }
EDATopicListener >> onMessageDo: aBlock [
	self subclassResponsibility
]

{ #category : #lifecycle }
EDATopicListener >> subscribe [
	self subclassResponsibility
]

{ #category : #lifecycle }
EDATopicListener >> unsubscribe [
	self subclassResponsibility
]
