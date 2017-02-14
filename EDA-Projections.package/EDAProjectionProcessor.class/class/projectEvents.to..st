projections
projectEvents: aCollectionOfEvents to: aCollectionOfProjectionClass
	aCollectionOfEvents
		do: [ :anEvent | aCollectionOfProjectionClass do: [ :aProjectionClass | anEvent updateProjection: aProjectionClass ] ]