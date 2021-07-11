Class {
	#name : #EDAMMCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMCommandHandlerTest >> testLoggingCommandHandler [
	| handler |
	handler := EDAMMLoggingCommandHandler
		on: (WriteStream on: String new).
	handler handleCommand: nil within: nil.
	self assert: (handler stream contents includesSubstring: 'nil')
]

{ #category : #tests }
EDAMMCommandHandlerTest >> testSimpleCommandHandler [
	| handler |
	handler := EDAMMDummyCommandHandler new.
	handler handleCommand: nil within: nil.
	self assert: handler commandHandled
]
