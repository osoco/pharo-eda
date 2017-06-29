bdd
checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection
	| storedEvents allEvents expectedStoredEvents |
	expectedNewStoredEvents
		ifNotNil: [ storedEvents := self application eventStore allEvents.
			expectedStoredEvents := OrderedCollection newFrom: previousEventsCollection.
			expectedStoredEvents addAll: expectedNewStoredEvents.
			self assert: storedEvents isNotEmpty.
			self assert: storedEvents size equals: expectedStoredEvents size.
			expectedStoredEvents
				doWithIndex: [ :eventMessageRegex :index |
					self assertEvent: (storedEvents at: index) greaseString matchesEventRegex: eventMessageRegex greaseString] ]
		ifNil: [ allEvents := self application eventStore allEvents.
			self
				assert: allEvents
				equals: (OrderedCollection newFrom: previousEventsCollection) ]
