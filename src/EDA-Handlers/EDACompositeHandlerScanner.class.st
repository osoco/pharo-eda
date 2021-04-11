Class {
	#name : #EDACompositeHandlerScanner,
	#superclass : #Object,
	#instVars : [
		'scanners'
	],
	#category : #'EDA-Handlers-Scanners'
}

{ #category : #'instance creation' }
EDACompositeHandlerScanner class >> with: aScanner and: anotherScanner [
	| result |
	result := self new .
	result addScanner: aScanner.
	result addScanner: anotherScanner.
	^ result
]

{ #category : #accessing }
EDACompositeHandlerScanner >> addScanner: aScanner [
	self scanners add: aScanner
]

{ #category : #scanning }
EDACompositeHandlerScanner >> allHandlerMethods [
	^ (self scanners collect: [ :s | s allHandlerMethods ]) flattened select: [ :i | i isNotNil ]
]

{ #category : #accessing }
EDACompositeHandlerScanner >> scanners [
	^ scanners ifNil: [ self scanners: OrderedCollection new. scanners ]
]

{ #category : #accessing }
EDACompositeHandlerScanner >> scanners: anObject [
	scanners := anObject
]
