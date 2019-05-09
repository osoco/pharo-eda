setup - repositories
setupRepositories
	EDAAggregateRepository
		allSubclassesDo: [ :repo | 
			repo setupEventStore: self eventStore.
			(EDAEventSourcingEvent allSubclasses
				select: [ :s | 
					(s greaseString beginsWithSubCollection: self eventClassPrefix)
						and: [ s aggregateRootClass = repo aggregateClass ] ])
				collect: [ :s | s repository: repo uniqueInstance ] ]