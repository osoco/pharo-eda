api
findEventsOfTenant: aTenant ofType: aType
	^ self
		findAllEventsOfTenant: aTenant matching: {('#instanceOf' -> aType greaseString)} asDictionary