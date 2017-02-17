persistence
removeAllProjections
	(EDAProjection subclasses reject: [ :projectionClass | projectionClass = EDATestEntityCounterProjection ])
		do: [ :aProjectionClass | Repository removeProjection: aProjectionClass ]