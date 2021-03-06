BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	aggregateRoot isDeleted ifTrue: [ aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new ].
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ | event |
			event := aggregateRoot perform: handlerSelectorSymbol with: aCommand.
			event aggregateRootVersion: aCommand aggregateRootVersion + 1.
			self assert: expectedEvent equals: event ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]