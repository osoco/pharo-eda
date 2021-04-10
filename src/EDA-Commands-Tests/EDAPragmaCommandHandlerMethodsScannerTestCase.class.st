Class {
	#name : #EDAPragmaCommandHandlerMethodsScannerTestCase,
	#superclass : #BabyMock2TestCase,
	#traits : 'EDATTestClassFactory',
	#classTraits : 'EDATTestClassFactory classTrait',
	#instVars : [
		'classFactory',
		'aCommandClass',
		'aCommandHandlerSuperclass',
		'anotherCommandClass'
	],
	#category : #'EDA-Commands-Tests'
}

{ #category : #running }
EDAPragmaCommandHandlerMethodsScannerTestCase >> setUp [
	self setUpClassFactory.
	self setUpStubs.
]

{ #category : #running }
EDAPragmaCommandHandlerMethodsScannerTestCase >> setUpStubs [
	aCommandHandlerSuperclass := self newClassName: 'EDACommandHandlerSuperclassStub'.
	aCommandClass := self newClassName: 'EDACommandClassStub'.
	anotherCommandClass := self newClassName: 'EDAAnotherCommandClassStub'.	

]

{ #category : #running }
EDAPragmaCommandHandlerMethodsScannerTestCase >> tearDown [
	self tearDownClassFactory
]

{ #category : #tests }
EDAPragmaCommandHandlerMethodsScannerTestCase >> testScannerCreation [
	| aClass aPragma scanner |
	aClass := protocol mock: 'aClass'.
	aPragma := protocol mock: 'aPragma'.
	scanner := EDAPragmaHandlerMethodScanner scannerPragma: aPragma from: aClass.
	self assert: scanner pragma equals: aPragma.
	self assert: scanner fromClass equals: aClass
]

{ #category : #tests }
EDAPragmaCommandHandlerMethodsScannerTestCase >> testScanning [
	| aCommandHandlerClass scanner |
	aCommandHandlerClass := self newSubclassOf: aCommandHandlerSuperclass instanceVariableNames: '' classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: EDACommandClassStub> ^2'.
	scanner := EDAPragmaHandlerMethodScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: (scanner allCommandHandlerMethods)
		equals: {(aCommandClass -> (aCommandHandlerClass >> #handlerCommandMethod:))} asSet

]

{ #category : #tests }
EDAPragmaCommandHandlerMethodsScannerTestCase >> testScanningIfPragmaIsNotInSubclass [
	| aCommandHandlerClass scanner |
	aCommandHandlerClass := self newClass.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: EDACommandClassStub> ^2'.
	scanner := EDAPragmaHandlerMethodScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: (scanner allCommandHandlerMethods)
		equals: nil.

]

{ #category : #tests }
EDAPragmaCommandHandlerMethodsScannerTestCase >> testScanningMultipleMethodsAndSubclasses [
	| aCommandHandlerClass scanner anotherCommandHandlerClass |
	aCommandHandlerClass := self newSubclassOf: aCommandHandlerSuperclass instanceVariableNames: '' classVariableNames: ''.
	anotherCommandHandlerClass := self
		newSubclassOf: aCommandHandlerSuperclass
		instanceVariableNames: ''
		classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: EDACommandClassStub> ^nil'.
	anotherCommandHandlerClass
		duringTestCompileSilently: 'handlerOtherCommandMethod: aCommand <pragmaTest: EDAAnotherCommandClassStub> ^nil'.
	scanner := EDAPragmaHandlerMethodScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: scanner allCommandHandlerMethods
		equals:
			{(aCommandClass -> (aCommandHandlerClass >> #handlerCommandMethod:)).
			(anotherCommandClass -> (anotherCommandHandlerClass >> #handlerOtherCommandMethod:))} asSet

]
