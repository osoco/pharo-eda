handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot processedEvents producedEvents |
	[ aggregateRoot := self buildAggregateRootFromCommand: aCommand.
	aggregateRoot isDeleted
		ifTrue: [ self
				logInfoMessage:
					'Discarding command ' , aCommand commandName greaseString , ' since '
						, aCommand aggregateRootClass greaseString , ' with id '
						, aCommand aggregateRootId greaseString , ' is already deleted.' ]
		ifFalse: [ producedEvents := OrderedCollection new.
			producedEvents add: (self delegateHandlingOfCommand: aCommand toAggregate: aggregateRoot).
			producedEvents := producedEvents flattened.
			processedEvents := self
				processGeneratedEvents: producedEvents
				forCommand: aCommand
				onAggregateRoot: aggregateRoot ] ]
		on: Error
		do: [ :exception | 
			producedEvents
				ifNotNil: [ :evts | 
					processedEvents := self
						manageCommandHandlingError: exception
						withEvents: evts
						usingErrorStrategy: strategy ] ].
	eventBus produceEvents: processedEvents.
	^ self