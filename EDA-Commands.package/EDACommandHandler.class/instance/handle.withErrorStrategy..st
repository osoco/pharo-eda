handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot processedEvents producedEvents |
	[
		aggregateRoot := self buildAggregateRootFromCommand: aCommand.
		aggregateRoot isDeleted
			ifTrue: [
				self logInfoMessage: 'Discarding command ', aCommand commandName, ' since ', aCommand aggregateRootClass greaseString, ' with id ', aCommand aggregateRootId, ' is already deleted.'
			] ifFalse: [
				producedEvents := self delegateHandlingOfCommand: aCommand toAggregate: aggregateRoot.
				processedEvents := self processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: aggregateRoot.
			]
		]
	on: Error
	do: [ :exception |
		producedEvents ifNotNil: [ :evts |
			processedEvents := self manageCommandHandlingError: exception withEvents: evts usingErrorStrategy: strategy
		]
	].
	eventBus produceEvents: processedEvents.
	^ self