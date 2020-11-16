public-entity-creation
ensureEventForEventSourcingEventClass: aEventSourcingEventClassModel
	| event |
	^ events
		at: aEventSourcingEventClassModel
		ifAbsent: [ event := self createEvent: aEventSourcingEventClassModel.
			self addEntity: event.
 self ensureEventPublishingForEvent: event .
			event ]