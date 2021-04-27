Class {
	#name : #EDADeleteCommandHandler,
	#superclass : #EDACommandHandler,
	#classInstVars : [
		'uniqueInstance',
		'eventBus',
		'eventStore'
	],
	#category : #'EDA-Handlers-Commands'
}

{ #category : #accessing }
EDADeleteCommandHandler class >> withEventStore: anEventStore eventBus: anEventBus andProjectorClass: aProjectorClass [
	| result |
	result := self new.
			result
				eventStore: anEventStore;
				eventBus: anEventBus;
				projectorClass: aProjectorClass.
	^ result
]

{ #category : #handling }
EDADeleteCommandHandler >> delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot [
	aCommand isDelete
		ifTrue: [
			^ anAggregateRoot handleDeleteCommand: aCommand
		] ifFalse: [
			EDAInvalidCommand signal
		]
					

]
