public-entity-creation
ensureClass: aClass
	"aClass is aSmalltalk. This method returns a FAMIXClass"

	| class |
	class := classes at: aClass ifAbsent: [ self createClass: aClass ].
	(importingContext shouldImportAggregate
		and: [ class isAggregateRoot ])
		ifTrue: [ self ensureAggregateForAggregateRootClass: class ].
	(importingContext shouldImportCommand and: [ class isCommand ])
		ifTrue: [ self ensureCommandForCommandClass: class ].
	(importingContext shouldImportEvent and: [ class isEvent ])
		ifTrue: [ self ensureEventForEventSourcingEventClass: class ].
	^ class