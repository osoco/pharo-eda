projection retrieval
retrieveLastProjectedEventTimestamp
	| currentProjections result |
	currentProjections := self retrieveAllProjections.
	result := self retrieveLastProjectedEventTimestampFromProjections: currentProjections.
	^ result