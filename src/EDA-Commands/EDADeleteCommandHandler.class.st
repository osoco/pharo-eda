Class {
	#name : #EDADeleteCommandHandler,
	#superclass : #EDACommandHandler,
	#classInstVars : [
		'uniqueInstance',
		'eventBus',
		'eventStore'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #accessing }
EDADeleteCommandHandler class >> eventBus [
	^ eventBus
]

{ #category : #accessing }
EDADeleteCommandHandler class >> eventBus: aBus [
	eventBus := aBus.
	self uniqueInstance: nil
]

{ #category : #accessing }
EDADeleteCommandHandler class >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDADeleteCommandHandler class >> eventStore: aStore [
	eventStore := aStore.
	self uniqueInstance: nil.
]

{ #category : #accessing }
EDADeleteCommandHandler class >> uniqueInstance [
	| result |
	result := uniqueInstance.
	result ifNil: [
		result := self new.
		result eventStore: self eventStore; eventBus: self eventBus.
		self uniqueInstance: result
	].
	^ result
]

{ #category : #accessing }
EDADeleteCommandHandler class >> uniqueInstance: anInstance [
	uniqueInstance := anInstance
]

{ #category : #handling }
EDADeleteCommandHandler >> delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot [
	aCommand isDelete
		ifTrue: [
			^ anAggregateRoot handleDeleteCommand: aCommand
		] ifFalse: [
			EDAInvalidCommandMessage signal
		]
					

]
