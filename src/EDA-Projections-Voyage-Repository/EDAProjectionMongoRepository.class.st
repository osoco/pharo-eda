Class {
	#name : #EDAProjectionMongoRepository,
	#superclass : #EDAProjectionVoyageRepository,
	#traits : 'EDATMongoHelper',
	#classTraits : 'EDATMongoHelper classTrait',
	#classInstVars : [
		'username',
		'password',
		'databaseName',
		'wireProtocolEnabled',
		'lazySynchronize',
		'forceEager',
		'ensuringCurrentReferencesOnQueries',
		'ensuringCurrentOnSave',
		'enableSingleton',
		'debug',
		'enableReplication',
		'host',
		'port',
		'authenticationMechanism',
		'urls',
		'tls'
	],
	#category : 'EDA-Projections-Voyage-Repository'
}

{ #category : #accessing }
EDAProjectionMongoRepository class >> authenticationMechanism [
	^ authenticationMechanism
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> authenticationMechanism: anObject [
	authenticationMechanism := anObject
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> databaseName [
	^ databaseName
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> databaseName: val [
	databaseName := val
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> debug [
	^ debug
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> debug: aBoolean [
	debug = aBoolean
		ifTrue: [ ^ self ].
	debug := aBoolean.
	self refreshVoyageSettings
]

{ #category : #'class initialization' }
EDAProjectionMongoRepository class >> doInitialize [
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
EDAProjectionMongoRepository class >> enableReplication [
	^ enableReplication
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> enableReplication: aBoolean [
	enableReplication = aBoolean
		ifTrue: [ ^ self ].
	enableReplication := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> enableSingleton [
	^ enableSingleton
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> enableSingleton: aBoolean [
	enableSingleton = aBoolean
		ifTrue: [ ^ self ].
	enableSingleton := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> ensuringCurrentOnSave [
	^ ensuringCurrentOnSave
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> ensuringCurrentOnSave: aBoolean [
	ensuringCurrentOnSave = aBoolean
		ifTrue: [ ^ self ].
	ensuringCurrentOnSave := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> ensuringCurrentReferencesOnQueries [
	^ ensuringCurrentReferencesOnQueries
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> ensuringCurrentReferencesOnQueries: aBoolean [
	ensuringCurrentReferencesOnQueries = aBoolean
		ifTrue: [ ^ self ].
	ensuringCurrentReferencesOnQueries := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> forceEager [
	^ forceEager
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> forceEager: aBoolean [
	forceEager = aBoolean
		ifTrue: [ ^ self ].
	forceEager := aBoolean.
	self refreshVoyageSettings
]

{ #category : #'class initialization' }
EDAProjectionMongoRepository class >> initialize [
	self doInitialize
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> lazySynchronize [
	^ lazySynchronize
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> lazySynchronize: aBoolean [
	lazySynchronize = aBoolean
		ifTrue: [ ^ self ].
	lazySynchronize := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> password [
	^ password
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> password: val [
	password := val
]

{ #category : #'refresh settings' }
EDAProjectionMongoRepository class >> refreshVoyageSettings [
	EDAVOProjectionMongoRepository allInstancesDo: [ :repo | self refreshVoyageSettingsOn: repo ]
]

{ #category : #'refresh settings' }
EDAProjectionMongoRepository class >> refreshVoyageSettingsOn: aRepository [
	aRepository username: self username.
	aRepository password: self password.
	aRepository debug: self debug.
	self enableReplication
		ifTrue: [ aRepository enableReplication ]
		ifFalse: [ aRepository disableReplication ].
	aRepository ensuringCurrentOnSave: self ensuringCurrentOnSave.
	aRepository ensuringCurrentReferencesOnQueries: self ensuringCurrentReferencesOnQueries.
	aRepository lazySynchronize: self lazySynchronize.
	self enableSingleton
		ifTrue: [ aRepository enableSingleton ]
		ifFalse: [ aRepository disableSingleton ].
	aRepository wireProtocolEnabled: self wireProtocolEnabled
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> tls [
	^ tls
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> tls: aBoolean [
	tls := aBoolean
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> urls [
	^ urls
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> urls: aString [
	urls := aString
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> username [
	^ username
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> username: anObject [
	username := anObject
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> wireProtocolEnabled [
	^ wireProtocolEnabled
]

{ #category : #accessing }
EDAProjectionMongoRepository class >> wireProtocolEnabled: aBoolean [
	wireProtocolEnabled = aBoolean
		ifTrue: [ ^ self ].
	wireProtocolEnabled := aBoolean.
	self refreshVoyageSettings
]

{ #category : #accessing }
EDAProjectionMongoRepository >> configureAuthentication [
	self flag: #TODO.	"Find out how to customize the authentication of the specific Mongo instance"
	self class authenticationMechanism beDefault.

]

{ #category : #persistence }
EDAProjectionMongoRepository >> mongoRepositoryClass [
	^ EDAVOProjectionMongoRepository
]
