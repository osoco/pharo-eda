Class {
	#name : #EDACommandBuilder,
	#superclass : #EDAMessageBuilder,
	#traits : 'EDATPragmaHelper',
	#classTraits : 'EDATPragmaHelper classTrait',
	#category : #'EDA-Commands-Builders'
}

{ #category : #meta }
EDACommandBuilder class >> errorClass [
	^ EDAInvalidCommandMessage
]

{ #category : #meta }
EDACommandBuilder class >> messageClass [
	^ EDACommand
]

{ #category : #meta }
EDACommandBuilder class >> pragmaSymbol [
	^ #commandName:
]

{ #category : #meta }
EDACommandBuilder >> errorClass [
	^ self class errorClass
]

{ #category : #meta }
EDACommandBuilder >> messageClass [
	^ self class messageClass
]

{ #category : #meta }
EDACommandBuilder >> pragmaSymbol [
	^ self class pragmaSymbol
]
