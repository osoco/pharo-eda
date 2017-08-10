handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot processedEvents producedEvents |
	[
		aggregateRoot := self buildAggregateRootFromCommand: aCommand.
		aggregateRoot isDeleted
			ifTrue: [
				Transcript
					print: 'Discarding command ';
					print: aCommand commandName;
					print: ' since ';
					print: aCommand aggregateRootClass greaseString;
					print: ' with id ';
					print: aCommand aggregateRootId;
					print: ' is already deleted.';
					cr.
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