Class {
	#name : #EDAMMCompositeCommandHandlerTest,
	#superclass : #TestCase,
	#category : #'EDA-Multimodule-Migration-Tests'
}

{ #category : #tests }
EDAMMCompositeCommandHandlerTest >> testCompositeCommandHandler [
	| handler |
	handler := EDAMMCompositeCommandHandler
		with: EDAMMDummyCommandHandler new
		with: (EDAMMLoggingCommandHandler on: (WriteStream on: String new)).
	self assert: (handler handleCommand: nil within: nil)
]
