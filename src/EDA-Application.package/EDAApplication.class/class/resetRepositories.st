reset - repositories
resetRepositories
	EDAAggregateRepository
		allSubclassesDo: [ :repo | repo setupEventStore: nil ]