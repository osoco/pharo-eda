projection retrieval
retrieveLastProjectedEventTimestampOfTenant: aTenant
	| currentProjections result |
	currentProjections := self retrieveAllProjectionsOfTenant: aTenant.
	result := self
		retrieveLastProjectedEventTimestampFromProjections: currentProjections.
	^ result