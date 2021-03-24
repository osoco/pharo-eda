Class {
	#name : #EDAMethodWrapperCommandHandlerTestCase,
	#superclass : #BabyMock2TestCase,
	#traits : 'EDATTestClassFactory',
	#classTraits : 'EDATTestClassFactory classTrait',
	#category : #'EDA-Commands-Tests'
}

{ #category : #mocking }
EDAMethodWrapperCommandHandlerTestCase >> setUpCommandHandlerMethod: resultingEventsCollection [
	| aMethod handlerMethodSource aCommandHandlerReceiver |
	aCommandHandlerReceiver := self newClass.
	handlerMethodSource := String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'handlerMethod: aCommand';
				cr;
				nextPutAll: '^ OrderedCollection newFrom: ';
				print: resultingEventsCollection asArray ].
	aCommandHandlerReceiver duringTestCompileSilently: handlerMethodSource.
	aMethod := aCommandHandlerReceiver >> #handlerMethod:.
	^ aMethod
]

{ #category : #tests }
EDAMethodWrapperCommandHandlerTestCase >> testCreation [
	| aMethod anEventStore anEventBus handler resultingEventsCollection |
	resultingEventsCollection := OrderedCollection
		newFrom: #('anything1' 'anything2').
	aMethod := self setUpCommandHandlerMethod: resultingEventsCollection.
	protocol describe
		allow: aMethod recv: #classClass;
		=> aMethod class.
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	handler := EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: anEventStore
		eventBus: anEventBus
		andProjectorClass: EDACompositeProjector.
	self assert: handler isNotNil.
	self assert: handler eventStore equals: anEventStore.
	self assert: handler eventBus equals: anEventBus.
	self assert: handler handlerMethod equals: aMethod.
	self assert: handler aggregateRootClass equals: aMethod methodClass
]

{ #category : #tests }
EDAMethodWrapperCommandHandlerTestCase >> testInvokeMethodHandler [
	| aCommand anEventStore anEventBus aMethod handler resultingEventsCollection aReceiver |
	resultingEventsCollection := OrderedCollection
		newFrom: #('anything1' 'anything2').
	aMethod := self setUpCommandHandlerMethod: resultingEventsCollection.
	aReceiver := aMethod methodClass new.
	aCommand := protocol mock: 'aCommand'.
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	handler := EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod
		eventStore: anEventStore
		eventBus: anEventBus
		andProjectorClass: EDACompositeProjector .
	self
		assertCollection: (handler invokeMethodHandlerWith: aCommand on: aReceiver)
		equals: resultingEventsCollection
]
