Class {
	#name : #EDAStompTopicListenerSettingsInMemoryAdapter,
	#superclass : #EDAStompSettingsInMemoryAdapter,
	#traits : 'EDATCommandListenerSettingsPort',
	#classTraits : 'EDATCommandListenerSettingsPort classTrait',
	#instVars : [
		'ack',
		'queue',
		'strategy',
		'restartOnCommandConsumingErrors'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #testing }
EDAStompTopicListenerSettingsInMemoryAdapter class >> accepts: anEDAApplication [
	^ true
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter class >> priority [
	^ 0
]

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

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> restartOnCommandConsumingErrors [
	^ restartOnCommandConsumingErrors
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> restartOnCommandConsumingErrors: aBoolean [
	restartOnCommandConsumingErrors := aBoolean
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAStompTopicListenerSettingsInMemoryAdapter >> strategy: aStrategy [
	strategy := aStrategy
]
