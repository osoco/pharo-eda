persistence
saveEvents: anEventCollection onAggregate: aggregateRoot
	anEventCollection do: [ :event | event save ]