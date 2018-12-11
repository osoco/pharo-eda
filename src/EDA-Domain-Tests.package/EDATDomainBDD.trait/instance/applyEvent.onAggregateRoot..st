BDD
applyEvent: anEvent onAggregateRoot: anAggregateRoot
	| eventClassName applyEventSelector applyEventSelectorSymbol error |
	eventClassName := anEvent class name.
	error := false.
	applyEventSelector := anAggregateRoot retrieveApplyEventMethod: anEvent withLogging: false.
	applyEventSelector
		ifNil: [ error := true ]
		ifNotNil: [ applyEventSelectorSymbol := applyEventSelector asSymbol.
			(anAggregateRoot respondsTo: applyEventSelectorSymbol)
				ifFalse: [ error := true ] ].
	error
		ifTrue: [ self fail: 'Aggregate root ' , anAggregateRoot class name asSymbol , ' is not able to handle events of type ' , eventClassName , ' and version ' , anEvent version greaseString]
		ifFalse: [ anAggregateRoot perform: applyEventSelectorSymbol with: anEvent ]