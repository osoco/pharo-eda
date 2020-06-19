persistence
allEvents
	^ EDAEventSourcingEvent
		selectAllSortBy:
			(OrderedCollection
				with: (#timestamp -> VOOrder ascending)
				with: (#_id -> VOOrder ascending)) asDictionary