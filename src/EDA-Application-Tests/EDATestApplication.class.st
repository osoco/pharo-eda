Class {
	#name : #EDATestApplication,
	#superclass : #EDAApplication,
	#category : 'EDA-Application-Tests'
}

{ #category : #lifecycle }
EDATestApplication class >> initialize [
	"Override me if you need a custom EDAApplication"
	self application: EDATestApplication
]

{ #category : #lifecycle }
EDATestApplication class >> setupCommandConsumerUnused [
	| proxy |
	super setupCommandConsumer.
	proxy := SynchronizedStompTopicListener wrap: EDATestApplication commandConsumer busListener.
	EDATestApplication commandConsumer busListener: proxy.
	^ self
]
