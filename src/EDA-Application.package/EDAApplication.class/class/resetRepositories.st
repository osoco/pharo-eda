reset - repositories
resetRepositories
	EDAAggregateRepository allSubclassesDo: [ :repo | repo eventStore: nil ]