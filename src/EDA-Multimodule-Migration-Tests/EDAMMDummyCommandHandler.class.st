Class {
	#name : #EDAMMDummyCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#instVars : [
		'commandHandled'
	],
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #accessing }
EDAMMDummyCommandHandler >> commandHandled [
	^ commandHandled
]

{ #category : #accessing }
EDAMMDummyCommandHandler >> commandHandled: aBoolean [
	commandHandled := aBoolean
]

{ #category : #'command handling' }
EDAMMDummyCommandHandler >> handleCommand: aCommand within: aContext [
	self commandHandled: true.
	^ false
]

{ #category : #initialization }
EDAMMDummyCommandHandler >> initialize [
	super initialize.
	self commandHandled: false
]
