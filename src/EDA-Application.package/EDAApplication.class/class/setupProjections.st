setup - projections
setupProjections
	| projectionClasses |
	self projectionSynchronizationEnabled
		ifTrue: [ projectionClasses := EDAProjection allSubclasses reject: [ :projectionClass | (projectionClass name beginsWithSubCollection: 'EDATest') or: [ projectionClass isAbstract ] ].
			projectionClasses do: [ :projectionClass | self setupProjectionRepositoryForProjection: projectionClass ] ]