Class {
	#name : #EDAStompSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATInMemoryAdapter',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATInMemoryAdapter classTrait',
	#instVars : [
		'host',
		'password',
		'port',
		'prefetchCount',
		'timeout',
		'username',
		'debug',
		'durable',
		'edaApplication'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> debug [
	^ debug
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> debug: aBoolean [
	debug := aBoolean
]

{ #category : #'class initialization' }
EDAStompSettingsInMemoryAdapter >> doInitialize [
	self host: nil.
	self port: nil.
	self username: nil.
	self password: nil.
	self timeout: nil.
		self durable: true.
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> durable [
	^ durable
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> durable: flag [
	durable := flag
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> edaApplication [
	^ edaApplication
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> edaApplication: anEDAApplication [
	edaApplication := anEDAApplication
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> host [
	^ host
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> host: val [
	host := val
]

{ #category : #'class initialization' }
EDAStompSettingsInMemoryAdapter >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> password [
	^ password
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> password: val [
	password := val
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> port [
	^ port
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> port: val [
	port := val
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> timeout [
	^ timeout
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> timeout: val [
	timeout := val
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> username [
	^ username
]

{ #category : #accessing }
EDAStompSettingsInMemoryAdapter >> username: val [
	username := val
]
