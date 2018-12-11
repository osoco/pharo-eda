accessing
projectionSynchronizationEnabled
	ProjectionSynchronizationEnabled ifNil: [ self projectionSynchronizationEnabled: true ].
	^ ProjectionSynchronizationEnabled