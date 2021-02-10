Class {
	#name : #EDAStompTopicPublisherSettingsInMemoryAdapter,
	#superclass : #EDAStompSettingsInMemoryAdapter,
	#traits : 'EDAEventPublisherSettingsPort',
	#classTraits : 'EDAEventPublisherSettingsPort classTrait',
	#instVars : [
		'errorExchange',
		'errorRoutingKey',
		'exchange',
		'routingKey'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAStompTopicPublisherSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

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

{ #category : #testing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> priority [
	^ 0
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> routingKey [
	^ routingKey
]

{ #category : #accessing }
EDAStompTopicPublisherSettingsInMemoryAdapter >> routingKey: val [
	routingKey := val
]
