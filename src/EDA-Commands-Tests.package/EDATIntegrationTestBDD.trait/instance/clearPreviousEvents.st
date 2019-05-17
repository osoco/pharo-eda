lifecycle
clearPreviousEvents
	self isEnvironmentIntegrationTest
		ifTrue: [ (self application eventStore findEventsOfAggregate: self aggregateRootClass) do: [ :evt | evt delete ] ]
		ifFalse: [ self fail: 'Not in integration test environment' ]