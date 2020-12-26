reset - repositories
resetRepositories
	EDAAggregateRepository
		allSubclassesDo: [ :repo | 
			repo eventStore: nil.
			EDAEventSourcingEvent allSubclasses
				select: [ :s | 
					(s greaseString beginsWith: self eventClassPrefix)
						and: [ s aggregateRootClass = repo aggregateClass ] ]
				thenCollect: [ :s | s repository: nil ] ]