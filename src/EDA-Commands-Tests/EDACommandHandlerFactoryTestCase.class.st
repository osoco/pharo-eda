Class {
	#name : #EDACommandHandlerFactoryTestCase,
	#superclass : #BabyMock2TestCase,
	#category : #'EDA-Commands-Tests'
}

{ #category : #tests }
EDACommandHandlerFactoryTestCase >> testCreation [
	| factory anEventStore anEventBus |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	factory := EDACommandHandlerFactory factoryWithEventStore: anEventStore eventBus: anEventBus.
	self assert: factory eventStore equals: anEventStore.
	self assert: factory eventBus equals: anEventBus.
]

{ #category : #tests }
EDACommandHandlerFactoryTestCase >> testFactoryFromHandlerMethod [
	| factory anEventStore anEventBus aMethod handler |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	aMethod := protocol mock: 'aMethod'.
	protocol describe
		allow: aMethod recv: #methodClass;
		=> Anything class.
	factory := EDACommandHandlerFactory
		factoryWithEventStore: anEventStore
		eventBus: anEventBus.
	handler := factory newFromHandlerMethod: aMethod andProjectorClass: nil.
	self assert: (handler isKindOf: EDAMethodWrapperCommandHandler).
	self assert: handler eventStore equals: anEventStore.
	self assert: handler eventBus equals: anEventBus.
	self assert: handler handlerMethod equals: aMethod
]
