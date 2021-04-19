Class {
	#name : #EDAPragmaBasedEventBuilder,
	#superclass : #EDAPragmaBasedBuilder,
	#category : #'EDA-Events-Builders'
}

{ #category : #builder }
EDAPragmaBasedEventBuilder class >> errorClass [
	^ EDAInvalidEventMessage
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
