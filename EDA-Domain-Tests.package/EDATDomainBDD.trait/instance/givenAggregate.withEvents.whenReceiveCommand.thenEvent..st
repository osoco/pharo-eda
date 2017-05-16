BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent
	| aggregateRoot handlerSelectorSymbol commandClassName |
		self flag: #TODO.	"Refactor EDACommandHandler and inherit from it to avoid unnecessary conventions on command-handling methods"

	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ | event |
			event := aggregateRoot perform: handlerSelectorSymbol with: aCommand.
			event aggregateRootVersion: aCommand aggregateRootVersion + 1.
			self assert: event equals: expectedEvent ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]