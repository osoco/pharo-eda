BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand shouldNotRaise: anException
	| aggregateRoot handlerSelectorSymbol commandClassName |
	self flag: #TODO.	"Refactor EDACommandHandler and inherit from it to avoid unnecessary conventions on command-handling methods"
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ self shouldnt: [ aggregateRoot perform: handlerSelectorSymbol with: aCommand ] raise: anException ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]