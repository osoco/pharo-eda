Class {
	#name : #EDAPragmaBasedEventBuilder,
	#superclass : #Object,
	#instVars : [
		'params',
		'name',
		'symbols'
	],
	#category : #'EDA-Events-Builders'
}

{ #category : #'instance creation' }
EDAPragmaBasedEventBuilder class >> newFor: aName with: eventParams [
	^ self new
		name: aName;
		params: eventParams;
		yourself
]

{ #category : #building }
EDAPragmaBasedEventBuilder >> build [
	| event class pragma |
	pragma := self retrievePragma.
	pragma
		ifNil: [ EDAInvalidEventMessage new
				signal: self name greaseString , ' event is not supported' ].
	class := self class environment
		at: pragma methodClass allInstances first greaseString asSymbol.
	event := class perform: pragma method selector with: self.
	^ event
]

{ #category : #accessing }
EDAPragmaBasedEventBuilder >> name [
	^ name
]

{ #category : #accessing }
EDAPragmaBasedEventBuilder >> name: anObject [
	name := anObject
]

{ #category : #accessing }
EDAPragmaBasedEventBuilder >> params [
	^ params
]

{ #category : #accessing }
EDAPragmaBasedEventBuilder >> params: anObject [
	params := anObject
]

{ #category : #building }
EDAPragmaBasedEventBuilder >> retrievePragma [
	| pragmas |
	pragmas := (Pragma allNamed: #eventName: inAndBelow: EDAExternalEvent class)
		select: [ :p | (p argumentAt: 1) = self name ].
	pragmas
		addAll:
			((Pragma allNamed: #eventName: inAndBelow: EDAEventSourcingEvent class)
				select: [ :p | (p argumentAt: 1) = self name ]).
	^ pragmas ifEmpty: [ nil ] ifNotEmpty: [ pragmas first ]
]
