Class {
	#name : #EDABuilder,
	#superclass : #Object,
	#instVars : [
		'params',
		'accessorMapping'
	],
	#category : #'EDA-Events-Builders'
}

{ #category : #'instance creation' }
EDABuilder class >> with: aDict [
	^ self new
		params: aDict;
		yourself
]

{ #category : #accessing }
EDABuilder >> accessorMapping [
	^ accessorMapping ifNil: [ self accessorMapping: Dictionary new. accessorMapping ]
]

{ #category : #accessing }
EDABuilder >> accessorMapping: aDictionary [
	accessorMapping := aDictionary
]

{ #category : #builder }
EDABuilder >> build: aClass [
	| result |
	result := aClass new.
	self accessorMapping
		keysAndValuesDo: [ :method :symbol | 
			| v |
			v := self params
				at: symbol
				ifAbsent: [ EDAInvalidEventMessage signal: symbol greaseString , ' not found' ].
			result perform: method with: v ].
	^ result
]

{ #category : #accessing }
EDABuilder >> params [
	^ params
]

{ #category : #accessing }
EDABuilder >> params: anObject [
	params := anObject
]

{ #category : #private }
EDABuilder >> withAccessor: aSymbol for: paramName [
	self accessorMapping at: aSymbol put: paramName
]

{ #category : #building }
EDABuilder >> withId [
	self withAccessor: #id: for: #id
]

{ #category : #building }
EDABuilder >> withKey [
	self withAccessor: #key: for: #key
]
