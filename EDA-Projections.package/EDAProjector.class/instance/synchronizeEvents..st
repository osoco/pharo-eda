event synchronization
synchronizeEvents: anEventCollection
	| timestamp filteredEvents |
	timestamp := self retrieveLastProjectedEventTimestamp.
	filteredEvents := self filterEventsToProject: anEventCollection accordingToTimestamp: timestamp.
	self projectFilteredEvents: filteredEvents