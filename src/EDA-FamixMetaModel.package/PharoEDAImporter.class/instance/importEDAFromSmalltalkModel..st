importing
importEDAFromSmalltalkModel: aModel
	aModel allModelClasses
		do: [ :classModel | 
			classModel isAggregateRoot
				ifTrue: [ self ensureAggregateForAggregateRootClass: classModel ].
			classModel isCommand
				ifTrue: [ self ensureCommandForCommandClass: classModel ].
			classModel isEvent
				ifTrue: [ self ensureEventForEventSourcingEventClass: classModel ].
			classModel isAggregateElement ifTrue: [ self ensureAggregateElementForAggregateElementClass: classModel ] ]