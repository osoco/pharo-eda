Class {
	#name : #EDAMongoSettingsInMemoryAdapter,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDAInMemoryAdapter',
	#classTraits : 'EDAPrintOnHelper classTrait + EDAInMemoryAdapter classTrait',
	#instVars : [
		'authenticationMechanism',
		'databaseName',
		'debug',
		'enableReplication',
		'enableSingleton',
		'ensuringCurrentOnSave',
		'ensuringCurrentReferencesOnQueries',
		'forceEager',
		'lazySynchronize',
		'password',
		'tls',
		'urls',
		'username',
		'wireProtocolEnabled'
	],
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> authenticationMechanism [
	^ authenticationMechanism
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> authenticationMechanism: anObject [
	authenticationMechanism := anObject
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> databaseName [
	^ databaseName
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> debug [
	^ debug
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> debug: aBoolean [
	debug = aBoolean
		ifTrue: [ ^ self ].
	debug := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> doInitialize [
	self urls: nil.
	self tls: nil.
	self databaseName: nil.
	self username: nil.
	self password: nil.
	self debug: nil.
	self enableReplication: nil.
	self enableSingleton: nil.
	self ensuringCurrentOnSave: nil.
	self ensuringCurrentReferencesOnQueries: nil.
	self forceEager: nil.
	self lazySynchronize: nil.
	self wireProtocolEnabled: nil
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> enableReplication [
	^ enableReplication
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> enableReplication: aBoolean [
	enableReplication = aBoolean
		ifTrue: [ ^ self ].
	enableReplication := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> enableSingleton [
	^ enableSingleton
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> enableSingleton: aBoolean [
	enableSingleton = aBoolean
		ifTrue: [ ^ self ].
	enableSingleton := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> ensuringCurrentOnSave [
	^ ensuringCurrentOnSave
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> ensuringCurrentOnSave: aBoolean [
	ensuringCurrentOnSave = aBoolean
		ifTrue: [ ^ self ].
	ensuringCurrentOnSave := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> ensuringCurrentReferencesOnQueries [
	^ ensuringCurrentReferencesOnQueries
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> ensuringCurrentReferencesOnQueries: aBoolean [
	ensuringCurrentReferencesOnQueries = aBoolean
		ifTrue: [ ^ self ].
	ensuringCurrentReferencesOnQueries := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> forceEager [
	^ forceEager
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> forceEager: aBoolean [
	forceEager = aBoolean
		ifTrue: [ ^ self ].
	forceEager := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> lazySynchronize [
	^ lazySynchronize
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> lazySynchronize: aBoolean [
	lazySynchronize = aBoolean
		ifTrue: [ ^ self ].
	lazySynchronize := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> password [
	^ password
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> password: anObject [
	password := anObject
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> tls [
	^ tls
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> tls: aBoolean [
	tls := aBoolean
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> urls [
	^ urls
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> urls: aString [
	urls := aString
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> username [
	^ username
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> username: anObject [
	username := anObject
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> wireProtocolEnabled [
	^ wireProtocolEnabled
]

{ #category : #accessing }
EDAMongoSettingsInMemoryAdapter >> wireProtocolEnabled: aBoolean [
	wireProtocolEnabled = aBoolean
		ifTrue: [ ^ self ].
	wireProtocolEnabled := aBoolean
]
