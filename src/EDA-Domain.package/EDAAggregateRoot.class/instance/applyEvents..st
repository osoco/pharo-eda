event handling
applyEvents: eventsCollection
	eventsCollection do: [ :event | self applyEvent: event ]