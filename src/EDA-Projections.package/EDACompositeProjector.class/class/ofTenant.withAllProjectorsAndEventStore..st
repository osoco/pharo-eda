instance creation
ofTenant: aTenant withAllProjectorsAndEventStore: anEventStore
	| result |
	result := self ofTenant: aTenant withEventStore: anEventStore.
	result
		projectors:
			(EDAProjector allSubclasses
				select:
					[ :class | class ~= self and: [ class isAbstract not and: [ class isEnabled ] ] ]
				thenCollect:
					[ :projectorClass | projectorClass ofTenant: aTenant withEventStore: anEventStore ]).
	^ result