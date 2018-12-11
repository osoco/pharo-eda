instance creation
withAllProjectorsAndEventStore: anEventStore
	| result |
	result := self withEventStore: anEventStore.
	result
		projectors:
			(EDAProjector allSubclasses
				select: [ :class | class ~= self and: [ class isAbstract not ] ]
				thenCollect: [ :projectorClass | projectorClass withEventStore: anEventStore ]).
	^ result