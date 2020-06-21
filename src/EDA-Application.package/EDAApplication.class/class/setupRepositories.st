setup - repositories
setupRepositories
	EDAAggregateRepository
		allSubclassesDo: [ :repo | repo setupEventStore: self eventStore ].
	EDAEventSourcingEvent voyageRepository: self eventStore repository.
	EDAEventSourcingEvent
		allSubclassesDo: [ :event | event voyageRepository: self eventStore repository ]