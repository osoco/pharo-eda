Class {
	#name : #EDASmtpClient,
	#superclass : #ZdcSecureSMTPClient,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'pendingLog'
	],
	#category : 'EDA-SMTP'
}

{ #category : #logging }
EDASmtpClient >> flushPendingLog [
	self pendingLog ifNotNil: [ :col | col do: [ :line | self logDebugMessage: line beautify: false ] ].
	self pendingLog: OrderedCollection new
]

{ #category : #accessing }
EDASmtpClient >> initialize [
	| result |
	result := super initialize.
	self pendingLog: OrderedCollection new.
	^ result
]

{ #category : #accessing }
EDASmtpClient >> logVerbose: aString [
	self pendingLog ifEmpty: [ self pendingLog: OrderedCollection new ].
	self pendingLog add: aString
]

{ #category : #accessing }
EDASmtpClient >> pendingLog [
	^ pendingLog
]

{ #category : #accessing }
EDASmtpClient >> pendingLog: aCollection [
	pendingLog := aCollection
]

{ #category : #accessing }
EDASmtpClient >> sendCommand: aString [
	| result |
	result := super sendCommand: aString.
	(aString = 'QUIT') ifTrue: [ self flushPendingLog ].
	^ result
]
