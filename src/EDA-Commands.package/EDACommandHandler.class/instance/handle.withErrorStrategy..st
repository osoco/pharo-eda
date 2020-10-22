handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot processedEvents producedEvents handlingResult |
	[ aggregateRoot := self buildAggregateRootFromCommand: aCommand.
	aggregateRoot isDeleted
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: aCommand aggregateRootClass greaseString;
								nextPutAll: ' with id ';
								nextPutAll: aCommand aggregateRootId greaseString;
								nextPutAll: ' is already deleted' ])
				andThrow: EDAInvalidCommandMessage ].
	self checkCreateCommand: aCommand forAggregateRoot: aggregateRoot.
	producedEvents := OrderedCollection new.
	handlingResult := self
		delegateHandlingOfCommand: aCommand
		toAggregate: aggregateRoot.
	((handlingResult isKindOf: EDAEventSourcingEvent)
		or: [ handlingResult isKindOf: OrderedCollection ])
		ifTrue: [ producedEvents add: handlingResult.
			producedEvents := producedEvents flattened.
			processedEvents := self
				processGeneratedEvents: producedEvents
				forCommand: aCommand
				onAggregateRoot: aggregateRoot ].
	eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception |
			self
				manageError: exception
				forCommand: aCommand
				usingErrorStrategy: strategy ].
	^ self