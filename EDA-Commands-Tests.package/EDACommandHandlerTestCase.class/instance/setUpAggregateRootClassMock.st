mocking
setUpAggregateRootClassMock
	| anAggregateRootClass |
	anAggregateRootClass := self newSubclassOf: Object instanceVariableNames: '' classVariableNames: 'appliedEvents'.
	anAggregateRootClass duringTestCompileSilently: 'applyEvents: eventsCollection appliedEvents := eventsCollection'.
	anAggregateRootClass class duringTestCompileSilently: 'appliedEvents ^appliedEvents'.
	^ anAggregateRootClass