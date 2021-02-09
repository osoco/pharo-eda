Class {
	#name : #EDAStompTopicPublisherSettingsInMemoryAdapter,
	#superclass : #EDAStompSettingsInMemoryAdapter,
	#instVars : [
		'errorExchange',
		'errorRoutingKey',
		'exchange',
		'routingKey'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #'class initialization' }
EDAStompTopicPublisherSettingsInMemoryAdapter >> doInitialize [
	super doInitialize.
	self exchange: nil.
	self routingKey: nil.
	self durable: true
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> errorExchange [
	^ errorExchange
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> errorExchange: aString [
	errorExchange := aString
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> errorRoutingKey [
	^ errorRoutingKey
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> errorRoutingKey: val [
	errorRoutingKey := val
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> exchange [
	^ exchange
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> exchange: val [
	exchange := val
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> routingKey [
	^ routingKey
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> routingKey: val [
	routingKey := val
]
