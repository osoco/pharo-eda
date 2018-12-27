event handling
applyEventsIgnoringExceptions: eventsCollection
	eventsCollection
		do: [ :event | 
			[ self applyEvent: event ]
				on: EDADomainException 
				do: [ :ex | ex resume ] ]