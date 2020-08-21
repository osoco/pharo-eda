persistence
findAllOfTenant: aTenant
	^ self voyageRepository
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :r | r findAllOfTenant: self ]