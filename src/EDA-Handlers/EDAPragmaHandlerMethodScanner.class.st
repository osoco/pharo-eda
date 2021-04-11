Class {
	#name : #EDAPragmaHandlerMethodScanner,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'pragma',
		'fromClass'
	],
	#category : #'EDA-Handlers-Scanners'
}

{ #category : #'instance creation' }
EDAPragmaHandlerMethodScanner class >> scannerPragma: aSymbol from: aClass [
	^ self new
		pragma: aSymbol;
		fromClass: aClass;
		yourself
]

{ #category : #scanning }
EDAPragmaHandlerMethodScanner >> allHandlerMethods [
	| handlerPragmas handlerMethodAssocs |
	handlerPragmas := Set new.
	self fromClass allSubclasses
		do:
			[ :subclass | handlerPragmas addAll: (Pragma allNamed: self pragma in: subclass) ].
	handlerMethodAssocs := (handlerPragmas
		select: [ :handlerPragma | 
			(self class environment
				at: (handlerPragma argumentAt: 1)
				ifAbsent: [ nil ]) isNotNil ])
		collect: [ :handlerPragma | 
			(self class environment at: (handlerPragma argumentAt: 1))
				-> handlerPragma method ].
	^ handlerMethodAssocs ifEmpty: [ nil ]
]

{ #category : #accessing }
EDAPragmaHandlerMethodScanner >> fromClass [
	^ fromClass
]

{ #category : #accessing }
EDAPragmaHandlerMethodScanner >> fromClass: anObject [
	fromClass := anObject
]

{ #category : #accessing }
EDAPragmaHandlerMethodScanner >> pragma [
	^ pragma
]

{ #category : #accessing }
EDAPragmaHandlerMethodScanner >> pragma: anObject [
	pragma := anObject
]
