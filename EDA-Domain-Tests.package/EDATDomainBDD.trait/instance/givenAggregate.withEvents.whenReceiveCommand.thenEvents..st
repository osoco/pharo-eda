BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := ('handle' , aCommand classNameWithoutPrefix, ':') asSymbol.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ self assertCollection: ( aggregateRoot perform: handlerSelectorSymbol with: aCommand ) equals: expectedResultingEvents asOrderedCollection  ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]