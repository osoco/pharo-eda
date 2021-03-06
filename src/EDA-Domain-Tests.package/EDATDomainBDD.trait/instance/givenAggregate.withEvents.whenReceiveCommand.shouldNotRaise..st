BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand shouldNotRaise: anException
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ self shouldnt: [ aggregateRoot perform: handlerSelectorSymbol with: aCommand ] raise: anException ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]