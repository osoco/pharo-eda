event projection
incrementCounterPerEntity: anEntityClass
	| projection |
	projection := Repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> anEntityClass asString)} asDictionary.
	projection ifNil: [
		projection := EDATestEntityCounterProjection withEntityClassName: anEntityClass asString ].
	projection counter: (projection counter + 1).
	Repository save: projection.