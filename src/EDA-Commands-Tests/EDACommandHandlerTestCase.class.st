Class {
	#name : #EDACommandHandlerTestCase,
	#superclass : #BabyMock2TestCase,
	#traits : 'EDATTestClassFactory',
	#classTraits : 'EDATTestClassFactory classTrait',
	#instVars : [
		'classFactory'
	],
	#category : #'EDA-Commands-Tests'
}

{ #category : #running }
EDACommandHandlerTestCase >> setUp [
	self setUpClassFactory
]

{ #category : #mocking }
EDACommandHandlerTestCase >> setUpAggregateRootClassMock [
	| anAggregateRootClass |
	anAggregateRootClass := self newSubclassOf: Object instanceVariableNames: '' classVariableNames: 'appliedEvents'.
	anAggregateRootClass duringTestCompileSilently: 'applyEvents: eventsCollection appliedEvents := eventsCollection'.
	anAggregateRootClass class duringTestCompileSilently: 'appliedEvents ^appliedEvents'.
	^ anAggregateRootClass
]

{ #category : #mocking }
EDACommandHandlerTestCase >> setUpCommandHandlerSubclassMock: producedEventsCollection [
	| aCommandHandlerClass  invokeCommandHandlerMethodSource |
	aCommandHandlerClass := self
		newSubclassOf: EDACommandHandler
		instanceVariableNames: 'invokedCommand invokedReceiver'
		classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'invokedCommand ^invokedCommand'.
	aCommandHandlerClass duringTestCompileSilently: 'invokedReceiver ^invokedReceiver'.	
	invokeCommandHandlerMethodSource := String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'invokeMethodHandlerWith: aCommand on: aReceiver'; cr;
				nextPutAll: 'invokedCommand := aCommand.'; cr;
				nextPutAll: 'invokedReceiver := aReceiver.'; cr;				
				nextPutAll: '^ OrderedCollection newFrom: ';
				print: producedEventsCollection asArray ].
	aCommandHandlerClass duringTestCompileSilently: invokeCommandHandlerMethodSource .
	^ aCommandHandlerClass
]

{ #category : #running }
EDACommandHandlerTestCase >> tearDown [
	self tearDownClassFactory
]

{ #category : #mocking }
EDACommandHandlerTestCase >> testHandleCommand [
]
