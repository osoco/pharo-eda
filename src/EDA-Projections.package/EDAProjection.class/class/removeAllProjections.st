persistence
removeAllProjections
	(EDAProjection subclasses
		reject: [ :projectionClass | projectionClass class name beginsWith: 'EDATest' ])
		do: [ :aProjectionClass | repository ifNotNil: [ :r | r removeProjection: aProjectionClass ] ]