Class {
	#name : #EDAApplications,
	#superclass : #Object,
	#traits : 'EDACLogging',
	#classTraits : 'EDACLogging classTrait',
	#instVars : [
		'registry',
		'edaApplicationsAnnouncer',
		'edaApplicationsSubscribers'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'EDA-Application'
}

{ #category : #logging }
EDAApplications class >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDAApplications class >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDAApplications class >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDAApplications class >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDAApplications class >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #accessing }
EDAApplications class >> uniqueInstance [
	| result |
	result := uniqueInstance.
	result
		ifNil: [ result := self new.
			self uniqueInstance: result ].
	^ result
]

{ #category : #accessing }
EDAApplications class >> uniqueInstance: anInstance [
	uniqueInstance := anInstance
]

{ #category : #initialization }
EDAApplications >> addApplicationsSubscriber: aSubscriber [
	aSubscriber setupAnnouncer: self edaApplicationsAnnouncer.

]

{ #category : #initialization }
EDAApplications >> doInitialize [
	self addApplicationsSubscriber: EDAApplicationsSubscriber new
]

{ #category : #accessing }
EDAApplications >> edaApplications [
	^ self registry values
]

{ #category : #accessing }
EDAApplications >> edaApplicationsAnnouncer [
	edaApplicationsAnnouncer
		ifNil: [ self edaApplicationsAnnouncer: Announcer new ].
	^ edaApplicationsAnnouncer
]

{ #category : #accessing }
EDAApplications >> edaApplicationsAnnouncer: anAnnouncer [
	edaApplicationsAnnouncer := anAnnouncer 
]

{ #category : #accessing }
EDAApplications >> edaApplicationsSubscribers [
	edaApplicationsSubscribers
		ifNil: [ self edaApplicationsSubscribers: OrderedCollection new ].
	^ edaApplicationsSubscribers
]

{ #category : #accessing }
EDAApplications >> edaApplicationsSubscribers: aCollection [
	edaApplicationsSubscribers := aCollection
]

{ #category : #initialization }
EDAApplications >> initialize [
	| result |
	result := super initialize.
	self doInitialize.
	^ result
]

{ #category : #announcement }
EDAApplications >> notifyApplicationRegistered: anEDAApplication [
	edaApplicationsAnnouncer announce: (EDAApplicationRegistered on: anEDAApplication)
]

{ #category : #logic }
EDAApplications >> register: anEDAApplication [
	self register: anEDAApplication under: anEDAApplication applicationName

]

{ #category : #logic }
EDAApplications >> register: anEDAApplication under: anApplicationName [
	self registry
		at: anApplicationName
		ifPresent: [ :app | EDAApplicationAlreadyRegistered signal: app printString ]
		ifAbsentPut: [ anEDAApplication ].
	self notifyApplicationRegistered: anEDAApplication
]

{ #category : #accessing }
EDAApplications >> registry [ 
	| result |
	result := registry.
	result ifNil: [ result := Dictionary new. self registry: result ].
	^ result
]

{ #category : #accessing }
EDAApplications >> registry: aDictionary [
	registry := aDictionary
]

{ #category : #logic }
EDAApplications >> unregister: anEDAApplication [
	self unregisterByName: anEDAApplication applicationName
]

{ #category : #logic }
EDAApplications >> unregisterByName: anApplicationName [
	self registry removeKey: anApplicationName ifAbsent: [  ]
]
