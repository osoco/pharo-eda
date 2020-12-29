setup - projections
setupProjections
	| projectionClasses |
	projectionClasses := EDAProjection allSubclasses
		reject: [ :projectionClass | 
			(projectionClass name beginsWithSubCollection: 'EDATest')
				or: [ projectionClass isAbstract ] ].
	projectionClasses add: EDAProjection.
	projectionClasses
		do:
			[ :projectionClass | 
			self setupProjectionRepositoryForProjection: projectionClass ]