instance creation
ofTenant: aTenant withAllProjectorsAndEventStore: anEventStore
	| result |
	result := self ofTenant: aTenant withEventStore: anEventStore.
	result projectorsByTenant
		at: aTenant
		put:
			((EDAProjector allSubclasses
				select:
					[ :class | class ~= self and: [ class isAbstract not and: [ class isEnabled ] ] ])
				collect:
					[ :projectorClass | projectorClass ofTenant: aTenant withEventStore: anEventStore ]).
	^ result