Class {
	#name : #EDAMessageParser,
	#superclass : #Object,
	#instVars : [
		'message'
	],
	#category : #'EDA-Messaging-Parsers'
}

{ #category : #'instance creation' }
EDAMessageParser class >> with: aString [
	^ self new message: aString; yourself
]

{ #category : #accessing }
EDAMessageParser >> message [
	^ message
]

{ #category : #private }
EDAMessageParser >> message: anObject [
	message := anObject
]

{ #category : #testing }
EDAMessageParser >> messageSupported [
	self shouldBeImplemented.
]

{ #category : #parsing }
EDAMessageParser >> parse [
	self shouldBeImplemented.
]
