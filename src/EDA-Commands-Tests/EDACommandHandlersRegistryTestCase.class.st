Class {
	#name : #EDACommandHandlersRegistryTestCase,
	#superclass : #BabyMock2TestCase,
	#category : #'EDA-Commands-Tests'
}

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testCreateRegistryWithScannerAndFactory [
	| aScanner aFactory registry aCommand aCommandHandler aHandlerMethod |
	aScanner := protocol mock: 'aScanner'.
	aFactory := protocol mock: 'aFactory'.
	aCommand := protocol mock: 'aCommand'.
	aHandlerMethod := protocol mock: 'aHandlerMethod'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: aScanner recv: #allCommandHandlerMethods;
		=> {(aCommand class -> aHandlerMethod)}.
	protocol describe
		once: aFactory recv: #newFromHandlerMethod:;
		with: aHandlerMethod;
		=> aCommandHandler.
	registry := EDACommandHandlersRegistry
		withScanner: aScanner
		factory: aFactory
		andProjectorClass: EDACompositeProjector.
	self
		assert: (registry handlerForCommand: aCommand)
		equals: aCommandHandler
]

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testHandlerNotRegistered [
	| registry  aCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	self assert: (registry handlerForCommand: aCommand) equals: nil
]

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testRegisterHandler [
	| registry aHandler aCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	aHandler := protocol mock: 'aHandler'.
	registry registerHandler: aHandler command: aCommand.
	self assert: (registry handlerForCommand: aCommand) equals: aHandler
]

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testRegisterHandlerForNilCommand [
	| registry aHandler |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aHandler := protocol mock: 'aHandler'.
	self should: [ registry registerHandler: aHandler command: nil ] raise: EDACommandError
]

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testRegisterHandlerOverwritesPreviousHandler [
	| registry  aCommand oldHandler newHandler |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	oldHandler := protocol mock: 'oldHandler'.
	newHandler := protocol mock: 'newHandler'.	
	registry registerHandler: oldHandler command: aCommand.
	registry registerHandler: newHandler command: aCommand.	
	self assert: (registry handlerForCommand: aCommand) equals: newHandler
]

{ #category : #tests }
EDACommandHandlersRegistryTestCase >> testRegistryUseCommandClass [
	| registry aHandler aCommand anotherCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	anotherCommand := protocol mock: 'anotherCommand'.	
	aHandler := protocol mock: 'aHandler'.
	registry registerHandler: aHandler command: aCommand.
	self assert: (registry handlerForCommand: anotherCommand) equals: aHandler
]
