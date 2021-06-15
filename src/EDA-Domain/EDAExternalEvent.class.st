Class {
	#name : #EDAExternalEvent,
	#superclass : #EDAEvent,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#category : #'EDA-Domain-External'
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

{ #category : #testing }
EDAExternalEvent >> isEventSourcingEvent [
	^ self class isEventSourcingEvent
]
