persistence
findAll
	^ repository ifNil: [ OrderedCollection new ] ifNotNil: [ :r | r findAll: self ]