Class {
	#name : #EDACommandHandler,
	#superclass : #EDAHandler,
	#traits : 'EDATAggregateRootHandler',
	#classTraits : 'EDATAggregateRootHandler classTrait',
	#category : #'EDA-Handlers-Commands'
}

{ #category : #'aggregate creation' }
EDACommandHandler >> buildAggregateRootFrom: aCommand [
	^ self
		buildAggregateRootFrom: aCommand
		andAggregateRootClass: (self retrieveAggregateRootClass: aCommand)
]

{ #category : #'aggregate creation' }
EDACommandHandler >> buildAggregateRootFrom: aCommand andAggregateRootClass: anAggregateRootClass [
	| result |
	result := self class
		buildAggregateRootOfTenant: aCommand tenant
		ofAggregateRootClass: anAggregateRootClass
		withCriteria: aCommand aggregateSelectionCriteria
		andEventStore: eventStore.
	result version = aCommand aggregateRootVersion
		ifFalse: [ self
				logWarningMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Aggregate root''s version (';
								nextPutAll: result version greaseString;
								nextPutAll: ') does not match command''s (';
								nextPutAll: aCommand aggregateRootVersion greaseString;
								nextPutAll: ').' ]) ].
	^ result
]

{ #category : #handling }
EDACommandHandler >> checkCommand: aCommand forAggregateRoot: anAggregateRoot [

	aCommand checkForAggregateRoot: anAggregateRoot.
]

{ #category : #handling }
EDACommandHandler >> delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot [
	self subclassResponsibility
]

{ #category : #handling }
EDACommandHandler >> handle: aCommand withErrorStrategy: strategy [
	| aggregateRoot processedEvents producedEvents handlingResult |
	[ aggregateRoot := self buildAggregateRootFrom: aCommand.
	self checkCommand: aCommand forAggregateRoot: aggregateRoot.
	handlingResult := self
		delegateHandlingOfCommand: aCommand
		toAggregate: aggregateRoot.
	producedEvents := handlingResult isCollection
		ifTrue: [ handlingResult ]
		ifFalse: [ OrderedCollection with: handlingResult ].
	processedEvents := self
		processGeneratedEvents: producedEvents
		for: aCommand
		onAggregateRoot: aggregateRoot.
	eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception | 
			self
				manageError: exception
				for: aCommand
				usingErrorStrategy: strategy ].
	^ processedEvents
]
