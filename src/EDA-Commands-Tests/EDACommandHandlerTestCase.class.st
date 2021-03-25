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

{ #category : #tests }
EDACommandHandlerTestCase >> testHandleCommand [
	| anEventStore anEventBus handler aCommand anAggregateRootClass aCommandHandlerClass producedEventsCollection previousEventsCollection aggRootId aggregateRootVersion tenant |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	aCommand := protocol mock: 'aCommand'.
	tenant := 'tenant'.
	aggRootId := 103.
	aggregateRootVersion := 1.
	producedEventsCollection := OrderedCollection newFrom: #(4 5 6 7).
	aCommandHandlerClass := self
		setUpCommandHandlerSubclassMock: producedEventsCollection.
	anAggregateRootClass := self setUpAggregateRootClassMock.
	previousEventsCollection := OrderedCollection newFrom: #(1 2 3).
	protocol describe
		allow: aCommand recv: #tenant;
		=> tenant.
	protocol describe
		allow: aCommand recv: #aggregateRootId;
		=> aggRootId.
	protocol describe
		allow: aCommand recv: #aggregateRootVersion;
		=> aggregateRootVersion.
	protocol describe
		once: anEventStore recv: #findEventsOfTenant:ofAggregate:whereId:;
		with: tenant and: anAggregateRootClass and: aggRootId;
		=> previousEventsCollection.
	protocol describe
		once: anEventStore recv: #saveEvents:;
		with: producedEventsCollection.
	protocol describe
		once: anEventBus recv: #produceEvents:;
		with: producedEventsCollection.
	handler := aCommandHandlerClass new
		eventStore: anEventStore;
		eventBus: anEventBus.
	protocol visualize: handler.
	handler aggregateRootClass: anAggregateRootClass.
	handler
		handle: aCommand
		withErrorStrategy: EDALaunchDebuggerErrorStrategy asString.
	self
		assertCollection: anAggregateRootClass appliedEvents
		equals: previousEventsCollection.
	self assert: handler invokedCommand equals: aCommand.
	self assert: (handler invokedReceiver isKindOf: anAggregateRootClass)
]
