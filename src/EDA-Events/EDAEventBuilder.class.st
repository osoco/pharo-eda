Class {
	#name : #EDAEventBuilder,
	#superclass : #EDAPragmaBasedMessageBuilder,
	#category : #'EDA-Events-Builders'
}

{ #category : #meta }
EDAEventBuilder class >> errorClass [
	^ EDAInvalidEventMessage
]

{ #category : #meta }
EDAEventBuilder class >> messageClass [
	^ EDAEvent
]

{ #category : #meta }
EDAEventBuilder class >> pragmaSymbol [
	^ #eventName:
]

{ #category : #testing }
EDAEventBuilder >> errorClass [
	^ self class errorClass
]

{ #category : #testing }
EDAEventBuilder >> messageClass [
	^ self class messageClass
]

{ #category : #testing }
EDAEventBuilder >> pragmaSymbol [
	^ self class pragmaSymbol
]
