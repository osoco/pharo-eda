Class {
	#name : #EDAExternalEvent,
	#superclass : #EDAEvent,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'timestamp',
		'version'
	],
	#category : #'EDA-Events-External'
}

{ #category : #testing }
EDAExternalEvent class >> isEventSourcingEvent [
	^ false
]

{ #category : #'instance creation' }
EDAExternalEvent class >> newForVersion: aVersion [
	^ self
		new
		version: aVersion;
		yourself
]

{ #category : #accessing }
EDAExternalEvent >> aggregateRootVersion [
	^ 'n/a'
]

{ #category : #accessing }
EDAExternalEvent >> correlationId [
	^ ''
]

{ #category : #accessing }
EDAExternalEvent >> delete [
	^ false
]

{ #category : #initialization }
EDAExternalEvent >> initialize [
	super initialize.
	self timestamp: DateAndTime now
]

{ #category : #testing }
EDAExternalEvent >> isEventSourcingEvent [
	^ self class isEventSourcingEvent
]

{ #category : #accessing }
EDAExternalEvent >> timestamp [
	^ timestamp
]

{ #category : #accessing }
EDAExternalEvent >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
EDAExternalEvent >> version [
	^ version
]

{ #category : #accessing }
EDAExternalEvent >> version: anObject [
	version := anObject
]
