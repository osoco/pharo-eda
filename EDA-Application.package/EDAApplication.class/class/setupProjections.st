initialization
setupProjections
	| projectionsClasses  |
	projectionsClasses := EDAProjection subclasses reject: [ :projectionClass | projectionClass name beginsWith: 'EDATest' ].
	self logInfoMessage: 'Setting up ' , (projectionsClasses ifNil: [ '0 projections' ] ifNotNil: [ :prjs | prjs size asString , ' projections' ]) , ' for this application...'.
	projectionsClasses do: [ :projectionClass | self setupProjection: projectionClass ]