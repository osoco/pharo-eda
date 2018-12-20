setup - repositories
setupRepositories
	EDAAggregateRepository allSubclassesDo: [ :repo | repo setupEventStore: self eventStore ]