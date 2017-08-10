handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot producedEvents |
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
				self processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: aggregateRoot.
			]
		]
	on: Error
	do: [ :exception |
		producedEvents := self manageCommandHandlingError: exception withEvents: producedEvents usingErrorStrategy: strategy
	].
	eventBus produceEvents: producedEvents.
	^ self