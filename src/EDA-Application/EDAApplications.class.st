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

{ #category : #logic }
EDAApplications >> register: anEDAApplication [
	self registry
		at: anEDAApplication applicationName
		ifPresent: [ :app | EDAApplicationAlreadyRegistered signal: app applicationName ]
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
	self registry removeKey: anEDAApplication applicationName
]
