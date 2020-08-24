bdd
checkNewStoredEvents: expectedNewStoredEvents ofTenant: aTenant givenPreviousEvents: previousEventsCollection
	| storedEvents allEvents expectedStoredEvents |
	expectedNewStoredEvents
		ifNotNil: [ :events |
			storedEvents := self application eventStore allEventsOfTenant: aTenant.
			expectedStoredEvents := OrderedCollection
				newFrom: previousEventsCollection.
			expectedStoredEvents addAll: events.
			self assert: storedEvents isNotEmpty.
			self assert: storedEvents size equals: expectedStoredEvents size.
			expectedStoredEvents
				keysAndValuesDo: [ :index :eventMessageRegex |
					| serializer |
					serializer := self buildEventSerializer.
					self
						assertEvent: (serializer writeEvent: (storedEvents at: index))
						matchesEventRegex: (serializer writeEvent: eventMessageRegex) ] ]
		ifNil: [ allEvents := self application eventStore allEventsOfTenant: aTenant.
			self
				assert: allEvents
				equals: (OrderedCollection newFrom: previousEventsCollection) ]