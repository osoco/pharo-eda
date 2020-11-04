public-entity-creation
ensureClass: aClass
	"aClass is aSmalltalk. This method returns a FAMIXClass"

	| class aggregate command event |
	class := classes at: aClass ifAbsent: [ self createClass: aClass ].
	(importingContext shouldImportAggregate
		and: [ class isAggregateRoot ])
		ifTrue: [ aggregate := self ensureAggregateForAggregateRootClass: class
			"class aggregate: aggregate" ].
	(importingContext shouldImportCommand and: [ class isCommand ])
		ifTrue: [ command := self ensureCommandForCommandClass: class
			"class commandClass: command" ].
	(importingContext shouldImportEvent and: [ class isEvent ])
		ifTrue: [ event := self ensureEventForEventSourcingEventClass: class.
			"class eventClass: event "].
	^ class