initialization
setupProjections
	| projectionClasses |
	self projectionSynchronizationEnabled
		ifTrue: [ projectionClasses := EDAProjection subclasses
				reject: [ :projectionClass | projectionClass name beginsWith: 'EDATest' ].
			projectionClasses do: [ :projectionClass | self setupProjectionRepositoryForProjection: projectionClass ] ]