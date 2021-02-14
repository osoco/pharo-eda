Class {
	#name : #EDAApplications,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'registry'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'EDA-Application'
}

{ #category : #accessing }
EDAApplications class >> uniqueInstance [
	| result |
	result := uniqueInstance.
	result
		ifNil: [ result := self new.
			self uniqueInstance: result ].
	^ result
]

{ #category : #accessing }
EDAApplications class >> uniqueInstance: anInstance [
	uniqueInstance := anInstance
]

{ #category : #accessing }
EDAApplications >> applications [
	^ self registry values
]

{ #category : #logic }
EDAApplications >> register: anEDAApplication [
	self register: anEDAApplication under: anEDAApplication applicationName

]

{ #category : #logic }
EDAApplications >> register: anEDAApplication under: anApplicationName [
	self registry
		at: anApplicationName
		ifPresent: [ :app | EDAApplicationAlreadyRegistered signal: app printString ]
		ifAbsentPut: [ anEDAApplication ]
]

{ #category : #accessing }
EDAApplications >> registry [ 
	| result |
	result := registry.
	result ifNil: [ result := Dictionary new. self registry: result ].
	^ result
]

{ #category : #accessing }
EDAApplications >> registry: aDictionary [
	registry := aDictionary
]

{ #category : #logic }
EDAApplications >> unregister: anEDAApplication [
	self unregisterByName: anEDAApplication applicationName
]

{ #category : #logic }
EDAApplications >> unregisterByName: anApplicationName [
	self registry removeKey: anApplicationName ifAbsent: [  ]
]
