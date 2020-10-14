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
		ifFalse: [ | handlingResult |
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
						onAggregateRoot: aggregateRoot ] ] ]
		on: Error
		do: [ :exception |
			producedEvents
				ifNotNil: [ :evts |
					processedEvents := self
						manageError: exception
						forCommand: aCommand
						usingErrorStrategy: strategy ] ].
	eventBus produceEvents: processedEvents.
	^ self