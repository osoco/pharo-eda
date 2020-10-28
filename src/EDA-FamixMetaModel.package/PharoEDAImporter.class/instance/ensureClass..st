public-entity-creation
ensureClass: aClass
	"aClass is aSmalltalk. This method returns a FAMIXClass"

	| class aggregate |
	class := classes at: aClass ifAbsent: [ self createClass: aClass ].
	importingContext shouldImportAggregate
		ifTrue: [ class isAggregateRoot
				ifTrue: [ 
					aggregate := self ensureAggregateForAggregateRootClass: class.
					class aggregate: aggregate ] ].
			
	^ class