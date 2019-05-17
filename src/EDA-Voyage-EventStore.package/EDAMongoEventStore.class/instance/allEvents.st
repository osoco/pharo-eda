accessing
allEvents
		^ self repository
		selectMany: EDAEventSourcingEvent
		where: Dictionary new
		sortBy:
			{(#timestamp -> VOOrder ascending).
			(#_id -> VOOrder ascending)} asDictionary