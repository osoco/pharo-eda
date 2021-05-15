Class {
	#name : #EDAPortResolver,
	#superclass : #Object,
	#traits : 'EDATPortResolver',
	#classTraits : 'EDATPortResolver classTrait',
	#instVars : [
		'environmentSettingsAdapterClass'
	],
	#category : #'EDA-Settings-Ports'
}

{ #category : #accessing }
EDAPortResolver >> environmentSettingsAdapterClass [
	^ environmentSettingsAdapterClass
]

{ #category : #accessing }
EDAPortResolver >> environmentSettingsAdapterClass: aClass [
	environmentSettingsAdapterClass := aClass
]

{ #category : #logic }
EDAPortResolver >> resolveSettingsPort: aPort [
	| candidates candidate |
	candidates := self availableAdapters: aPort.
	candidate := candidates
		ifEmpty: [ nil ]
		ifNotEmpty: [ :col | col first ].
	^ candidate ifNil: [ nil ] ifNotNil: [ :c | c new ]
]
