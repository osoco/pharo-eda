BDD
applyEvent: anEvent onAggregateRoot: anAggregateRoot
| eventClassName applyEventSelectorSymbol |
eventClassName := anEvent class name.
applyEventSelectorSymbol := ('apply' , (eventClassName copyFrom: (anEvent eventClassPrefix size + 1) to: eventClassName size), ':') asSymbol.
(anAggregateRoot respondsTo: applyEventSelectorSymbol)
	ifTrue: [ anAggregateRoot perform: applyEventSelectorSymbol with: anEvent ]
	ifFalse: [ self fail: 'Aggregate root ' , anAggregateRoot class name asSymbol , ' is not able to handle events of type ' , eventClassName ].