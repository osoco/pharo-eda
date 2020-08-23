instance creation
ofTenant: aTenant withEventStore: anEventStore
	^ self new
		tenant: aTenant;
		eventStore: anEventStore;
		yourself