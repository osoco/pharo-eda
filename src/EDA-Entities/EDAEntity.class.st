Class {
	#name : #EDAEntity,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'id'
	],
	#category : #'EDA-Entities'
}

{ #category : #accessing }
EDAEntity >> id [
	^ id
]

{ #category : #accessing }
EDAEntity >> id: anObject [
	id := anObject
]
