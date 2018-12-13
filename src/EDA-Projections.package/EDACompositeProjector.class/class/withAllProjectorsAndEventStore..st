instance creation
withAllProjectorsAndEventStore: anEventStore
	| result |
	result := self withEventStore: anEventStore.
	result
		projectors:
			(((EDAProjector allSubclasses select: [ :class | class ~= self and: [ class isAbstract not ] ])
				collect: [ :projectorClass | projectorClass withEventStore: anEventStore ]) sort: [ :i :j | i class order < j class order ]).
	^ result