BDD
givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents
	| aggregateRoot handlerSelectorSymbol commandClassName |
		self flag: #TODO.	"Refactor EDACommandHandler and inherit from it to avoid unnecessary conventions on command-handling methods"

	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ | resultingEvents |
			resultingEvents := aggregateRoot perform: handlerSelectorSymbol with: aCommand.
			self assert: resultingEvents isNotNil.
			resultingEvents do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1 ].
			self assert: resultingEvents size equals: expectedResultingEvents size.
			resultingEvents doWithIndex: [ :e :i | self assert: e equals: (expectedResultingEvents at: i) ]
			"self assertCollection: resultingEvents equals: expectedResultingEvents asOrderedCollection" ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]