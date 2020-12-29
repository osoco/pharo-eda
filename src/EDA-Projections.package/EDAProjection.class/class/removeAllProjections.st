persistence
removeAllProjections
	(EDAProjection subclasses
		reject:
			[ :projectionClass | (projectionClass class name beginsWith: 'EDATest') or: [ projectionClass isAbstract ] ])
		do: [ :aProjectionClass | 
			self repository
				ifNotNil: [ :r | r removeProjection: aProjectionClass ] ]