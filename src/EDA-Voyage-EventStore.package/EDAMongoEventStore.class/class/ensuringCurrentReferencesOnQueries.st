accessing
ensuringCurrentReferencesOnQueries
	ensuringCurrentReferencesOnQueries ifNil: [ self ensuringCurrentReferencesOnQueries: true ].
	^ ensuringCurrentReferencesOnQueries