event synchronization
synchronizeEventsBasedOnLastProjectedEventTimestamp: anEventCollection ofTenant: aTenant
	| timestamp filteredEvents |
	timestamp := self
		retrieveLastProjectedEventTimestampOfTenant: aTenant.
	filteredEvents := self
		filterEventsToProject: anEventCollection
		accordingToTimestamp: timestamp.
	self projectFilteredEvents: filteredEvents ofTenant: aTenant