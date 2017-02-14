tests
testProjectionProcessing
	| events |
	events := self buildTestEvents: 10.
	EDAProjectionProcessor projectEvents: events.
	self assert: (repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> GCApplicationCreated asString)} asDictionary) counter equals: 10.
	self assert: (repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> GCAchievementTypeCreated asString)} asDictionary) counter equals: 10.
	self assert: (repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> GCAchievementGranted asString)} asDictionary) counter equals: 10.
	self assert: (repository selectOne: EDATestEntityCounterProjection where: {('entityClassName' -> GCNewPlayerCreated asString)} asDictionary) counter equals: 10.