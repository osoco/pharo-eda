public-entity-creation
ensureEventPublishingForEvent: anEDAEventModel
	| eventPublishing |
	^ eventPublishings 
		at: anEDAEventModel
		ifAbsent: [ eventPublishing := self createEventPublishing: anEDAEventModel.
			eventPublishing ifNotNil: [ self addEntity: eventPublishing ].
			eventPublishing ]