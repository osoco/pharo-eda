Class {
	#name : #EDADefaultEventBuilder,
	#superclass : #Object,
	#instVars : [
		'params',
		'name'
	],
	#category : #'EDA-Events-Builders'
}

{ #category : #'instance creation' }
EDADefaultEventBuilder class >> newFor: aName with: eventParams [
	^ self new
	name: aName; 
		params: eventParams;
		yourself
]

{ #category : #building }
EDADefaultEventBuilder >> build [
	| event class pragma |
	pragma := self retrievePragma.
	class := pragma methodClass allInstances first.
	event := class perform: pragma method with: self.
	^ event
]

{ #category : #accessing }
EDADefaultEventBuilder >> name [
	^ name
]

{ #category : #accessing }
EDADefaultEventBuilder >> name: anObject [
	name := anObject
]

{ #category : #accessing }
EDADefaultEventBuilder >> params [
	^ params
]

{ #category : #accessing }
EDADefaultEventBuilder >> params: anObject [
	params := anObject
]

{ #category : #building }
EDADefaultEventBuilder >> retrievePragma [
	| pragmas |
	pragmas := (Pragma allNamed: #eventName: inAndBelow: EDACommand)
		select:
			[ :p | (p argumentAt: 1) = (self name) ].
	^ pragmas ifEmpty: [ nil ] ifNotEmpty: [ pragmas first ]
]
