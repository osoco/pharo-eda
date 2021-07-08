Class {
	#name : #EDAMMCompositeCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#instVars : [
		'handlers'
	],
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'instance creation' }
EDAMMCompositeCommandHandler class >> with: handler1 with: handler2 [
	^ self new addHandler: handler1; addHandler: handler2; yourself
]

{ #category : #adding }
EDAMMCompositeCommandHandler >> addHandler: aHandler [
	self handlers add: aHandler
]

{ #category : #'command handling' }
EDAMMCompositeCommandHandler >> handleCommand: aCommand within: aContext [
	^ self handlers
		ifEmpty: [ false ]
		ifNotEmpty: [ :c | 
			c anySatisfy: [ :h | h handleCommand: aCommand within: aContext].
			true ]
]

{ #category : #accessing }
EDAMMCompositeCommandHandler >> handlers [
	^ handlers ifNil: [ self handlers: OrderedCollection new. handlers ]
]

{ #category : #accessing }
EDAMMCompositeCommandHandler >> handlers: anObject [
	handlers := anObject
]
