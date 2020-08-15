event synchronization
synchronizeEvents: anEventCollection ofTenant: aTenant
	"self synchronizeEventsBasedOnLastProjectedEventTimestamp: anEventCollection"

	self projectFilteredEvents: anEventCollection ofTenant: aTenant