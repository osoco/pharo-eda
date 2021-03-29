Class {
	#name : #EDACommandDispatcherTestCase,
	#superclass : #BabyMock2TestCase,
	#instVars : [
		'dispatcher',
		'handlersRegistry'
	],
	#category : #'EDA-Commands-Tests'
}

{ #category : #tests }
EDACommandDispatcherTestCase >> setUp [
	handlersRegistry := protocol mock: 'aCommandHandlerRegistry'.
	dispatcher := EDACommandDispatcher
		withRegistry: handlersRegistry
		eventStore: EDAVolatileEventStore new
		andEventProducer: EDAAcceptEverything new.
	protocol visualize: dispatcher
]

{ #category : #tests }
EDACommandDispatcherTestCase >> testCreateDispatcher [
	self assert: dispatcher handlersRegistry equals: handlersRegistry. 
]

{ #category : #tests }
EDACommandDispatcherTestCase >> testDispatchCommand [
	| aCommand aCommandHandler |
	aCommand := protocol mock: 'aCommand'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: handlersRegistry recv: #handlerForCommand:;
		with: aCommand;
		=> aCommandHandler.
	protocol describe
		once: aCommandHandler recv: #handle:withErrorStrategy:;
		with: aCommand.
	dispatcher dispatch: aCommand usingStrategy: EDACommandConsumingErrorBehavior strategy
]

{ #category : #tests }
EDACommandDispatcherTestCase >> testDispatchCommandNotRegistered [
	| aCommand aCommandHandler |
	aCommand := protocol mock: 'aCommand'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: handlersRegistry recv: #handlerForCommand:;
		with: aCommand;
		=> nil.
	self
		should: [ dispatcher dispatch: aCommand usingStrategy: EDACommandConsumingErrorBehavior strategy ]
		raise: EDACommandHandlerNotFound
]

{ #category : #tests }
EDACommandDispatcherTestCase >> testDispatchNilCommand [
	self should: [ dispatcher dispatch: nil usingStrategy: EDACommandConsumingErrorBehavior strategy ] raise: EDACommandError
]
