accessing
allEvents
	^ EDAEventSourcingEvent selectAllSortBy: { (#timestamp -> VOOrder ascending) . (#'_id' -> VOOrder ascending) } asDictionary