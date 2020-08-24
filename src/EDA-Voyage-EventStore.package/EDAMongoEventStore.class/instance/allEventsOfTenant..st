persistence
allEventsOfTenant: aTenant
	| eventsCriteria |
	eventsCriteria := (OrderedCollection
		with: 'tenant' -> aTenant greaseString)
		asDictionary.
	^ EDAEventSourcingEvent
		selectMany: eventsCriteria
		sortBy: (OrderedCollection with: #timestamp -> VOOrder ascending with: #_id -> VOOrder ascending) asDictionary