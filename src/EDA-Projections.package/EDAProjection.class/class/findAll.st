persistence
findAll
	^ self voyageRepository
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :r | r findAll: self ]