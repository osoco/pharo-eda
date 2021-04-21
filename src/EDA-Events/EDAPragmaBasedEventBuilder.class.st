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
	^ self retrievePragma: #eventName: inAndBelow: EDAEvent class
"	| pragmas |
	pragmas := (Pragma allNamed: #eventName: inAndBelow: EDAExternalEvent class)
		select: [ :p | (p argumentAt: 1) = self name ].
	pragmas := pragmas
		union:
			((Pragma allNamed: #eventName: inAndBelow: EDAEventSourcingEvent class)
				select: [ :p | (p argumentAt: 1) = self name ]).
	^ pragmas ifEmpty: [ nil ] ifNotEmpty: [ pragmas first ]"
]
