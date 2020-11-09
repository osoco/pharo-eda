public-entity-creation
ensureEventForEventSourcingEventClass: aEventSourcingEventClassModel
	| event |
	^ events
		at: aEventSourcingEventClassModel
		ifAbsent: [ event := self createEvent: aEventSourcingEventClassModel.
			self addEntity: event.
			importingContext shouldImportEventPublishing
				ifTrue: [ self ensureEventPublishingForEvent: event ].
			event ]