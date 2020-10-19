handling
handle: aCommand withErrorStrategy: strategy
	| aggregateRoot processedEvents producedEvents |
	[ aggregateRoot := self buildAggregateRootFromCommand: aCommand.
	aggregateRoot isDeleted
		ifTrue: [ self
				logInfoMessage: (String streamContents: [ :s | s nextPutAll: 
					'Discarding command '; nextPutAll: aCommand commandName greaseString ; nextPutAll: ' since '
						; nextPutAll: aCommand aggregateRootClass greaseString; nextPutAll: ' with id '
						; nextPutAll: aCommand aggregateRootId greaseString ; nextPutAll: ' is already deleted.' ]) ]
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
						onAggregateRoot: aggregateRoot ] ].
	eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception | 
			self
				manageError: exception
				forCommand: aCommand
				usingErrorStrategy: strategy ].
	^ self