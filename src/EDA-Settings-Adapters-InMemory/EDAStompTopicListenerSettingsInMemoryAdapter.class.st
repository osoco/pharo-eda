Class {
	#name : #EDAStompTopicListenerSettingsInMemoryAdapter,
	#superclass : #EDAStompSettingsInMemoryAdapter,
	#instVars : [
		'ack',
		'queue'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> ack [
	^ ack
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> ack: val [
	self assert: (#(#auto #client #'client-individual') includes: val).
	ack := val
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> destination [
	^ '/amq/queue/' , self queue
]

{ #category : #initialization }
EDAStompTopicListenerSettingsInMemoryAdapter >> doInitialize [
	super doInitialize.
	self queue: nil.
	self prefetchCount: nil.
	self durable: true.
	self ack: #'client-individual'
]

{ #category : #initialization }
EDAStompTopicListenerSettingsInMemoryAdapter >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> prefetchCount [
	^ prefetchCount
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> prefetchCount: val [
	prefetchCount := val
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> queue [
	^ queue
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> queue: val [
	queue := val
]
