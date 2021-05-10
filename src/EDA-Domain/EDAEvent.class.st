Class {
	#name : #EDAEvent,
	#superclass : #Announcement,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'id',
		'version',
		'tenant',
		'timestamp'
	],
	#category : #'EDA-Domain-Events'
}

{ #category : #accessing }
EDAEvent >> id [
	^ id
]

{ #category : #accessing }
EDAEvent >> id: anObject [
	id := anObject
]

{ #category : #accessing }
EDAEvent >> initialize [
	super initialize.
	self id: UUID new greaseString.
	self timestamp: DateAndTime now asUTC.

]

{ #category : #accessing }
EDAEvent >> tenant [
	^ tenant
]

{ #category : #accessing }
EDAEvent >> tenant: aString [
	tenant := aString
]

{ #category : #accessing }
EDAEvent >> timestamp [
	^ timestamp
]

{ #category : #accessing }
EDAEvent >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
EDAEvent >> version [
	| result |
	result := version.
	result
		ifNil: [ result := 1.
			self version: result ].
	^ result
]

{ #category : #accessing }
EDAEvent >> version: aNumber [
	version := aNumber
]
