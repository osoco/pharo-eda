Class {
	#name : #EDAMMLoggingCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#instVars : [
		'stream'
	],
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'instance creation' }
EDAMMLoggingCommandHandler class >> on: aWriteStream [
	^ self new stream: aWriteStream; yourself
]

{ #category : #'command handling' }
EDAMMLoggingCommandHandler >> handleCommand: aCommand within: aContext [
	self stream nextPutAll: aCommand printString.
	^ false
]

{ #category : #accessing }
EDAMMLoggingCommandHandler >> stream [
	^ stream
]

{ #category : #accessing }
EDAMMLoggingCommandHandler >> stream: anObject [
	stream := anObject
]
