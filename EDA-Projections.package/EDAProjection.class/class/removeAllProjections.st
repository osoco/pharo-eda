persistence
removeAllProjections
	(EDAProjection subclasses reject: [ :projectionClass | projectionClass class name beginsWith: 'EDATest' ])
		do: [ :aProjectionClass | Repository removeProjection: aProjectionClass ]