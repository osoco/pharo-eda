setup - events
setupRepositories
	EDAAggregateRepository allSubclassesDo: [ :repo | repo setupEventStore: self eventStore ]