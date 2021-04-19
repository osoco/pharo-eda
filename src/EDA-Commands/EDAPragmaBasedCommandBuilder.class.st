Class {
	#name : #EDAPragmaBasedCommandBuilder,
	#superclass : #EDAPragmaBasedBuilder,
	#category : #'EDA-Commands-Builders'
}

{ #category : #builder }
EDAPragmaBasedCommandBuilder class >> errorClass [
	^ EDAInvalidCommandMessage
]

{ #category : #pragmas }
EDAPragmaBasedCommandBuilder >> retrievePragma [
	^ self retrievePragma: #commandName: inAndBelow: EDACommand class
]
