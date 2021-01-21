Class {
	#name : #EDACommandDispatcherTestCase,
	#superclass : #BabyMock2TestCase,
	#instVars : [
		'dispatcher',
		'handlersRegistry'
	],
	#category : 'EDA-Commands-Tests'
}

{ #category : #tests }
EDACommandDispatcherTestCase >> setUp [
	handlersRegistry := protocol mock: 'aCommandHandlerRegistry'.
	dispatcher := EDACommandDispatcher withRegistry: handlersRegistry.
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
	dispatcher dispatch: aCommand
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
	self should: [ dispatcher dispatch: aCommand ] raise: EDACommandHandlerNotFound
]

{ #category : #tests }
EDACommandDispatcherTestCase >> testDispatchNilCommand [
	|   |
	self should: [ dispatcher dispatch: nil ] raise: EDACommandError
]
