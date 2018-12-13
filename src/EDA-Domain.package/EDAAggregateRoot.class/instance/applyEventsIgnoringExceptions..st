event handling
applyEventsIgnoringExceptions: eventsCollection
	eventsCollection do: [ :event | [ self applyEvent: event ] on: Exception do: [ :ex | ex resume ] ]