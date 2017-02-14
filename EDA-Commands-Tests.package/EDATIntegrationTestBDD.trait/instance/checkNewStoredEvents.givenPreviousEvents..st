bdd
checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection
	| storedEvents allEvents expectedStoredEvents |
	expectedNewStoredEvents
		ifNotNil: [
			storedEvents := self application eventStore
				findEventsOfAggregate: expectedNewStoredEvents first aggregateRootClass
				whereId: expectedNewStoredEvents first id.
			expectedStoredEvents := OrderedCollection newFrom: previousEventsCollection.
			expectedStoredEvents addAll: expectedNewStoredEvents.
			self assertCollection: storedEvents equals: expectedStoredEvents ]
		ifNil: [
			allEvents := self application eventStore allEvents.
			self assert: allEvents equals: (OrderedCollection newFrom: previousEventsCollection) ]