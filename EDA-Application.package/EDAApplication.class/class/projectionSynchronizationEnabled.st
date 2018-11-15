accessing
projectionSynchronizationEnabled
	projectionSynchronizationEnabled ifNil: [ self projectionSynchronizationEnabled: true ].
	^ projectionSynchronizationEnabled