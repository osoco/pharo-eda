persistence
removeAllProjectionsOfTenant: aTenant
	(EDAProjection subclasses
		reject:
			[ :projectionClass | projectionClass class name beginsWith: 'EDATest' ])
		do: [ :aProjectionClass | 
			self voyageRepository
				ifNotNil: [ :r | r removeProjection: aProjectionClass ofTenant: aTenant] ]