event projection
incrementCounterPerEntity: anEntityClass
	| projection |
	projection := repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> anEntityClass asString)} asDictionary.
	projection ifNil: [ 
		projection := EDATestEntityCounterProjection withEntityClassName: anEntityClass asString ].
	projection counter: (projection counter + 1).