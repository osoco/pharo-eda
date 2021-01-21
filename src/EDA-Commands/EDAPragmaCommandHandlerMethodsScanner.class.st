Class {
	#name : #EDAPragmaCommandHandlerMethodsScanner,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'pragma',
		'fromClass'
	],
	#category : 'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDAPragmaCommandHandlerMethodsScanner class >> scannerPragma: aSymbol from: aClass [
	^ self new
		pragma: aSymbol;
		fromClass: aClass;
		yourself
]

{ #category : #scanning }
EDAPragmaCommandHandlerMethodsScanner >> allCommandHandlerMethods [
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
EDAPragmaCommandHandlerMethodsScanner >> fromClass [
	^ fromClass
]

{ #category : #accessing }
EDAPragmaCommandHandlerMethodsScanner >> fromClass: anObject [
	fromClass := anObject
]

{ #category : #accessing }
EDAPragmaCommandHandlerMethodsScanner >> pragma [
	^ pragma
]

{ #category : #accessing }
EDAPragmaCommandHandlerMethodsScanner >> pragma: anObject [
	pragma := anObject
]
