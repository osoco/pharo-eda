Class {
	#name : #EDALogEvent,
	#superclass : #Announcement,
	#instVars : [
		'timestamp'
	],
	#classVars : [
		'EDALogEventAnnouncer'
	],
	#category : 'EDA-Logging'
}

{ #category : #accessing }
EDALogEvent class >> announcer [
	EDALogEventAnnouncer ifNil: [ EDALogEventAnnouncer := Announcer new ].
	^ EDALogEventAnnouncer

]

{ #category : #accessing }
EDALogEvent >> announcer [
	^ self class announcer
]

{ #category : #actions }
EDALogEvent >> emit [
	self announcer announce: self
]

{ #category : #initialization }
EDALogEvent >> initialize [
	super initialize.
	timestamp := DateAndTime now
]

{ #category : #accessing }
EDALogEvent >> timestamp [
	^ timestamp
]
