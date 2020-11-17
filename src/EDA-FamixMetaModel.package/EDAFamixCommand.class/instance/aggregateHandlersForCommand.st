view
aggregateHandlersForCommand
	^ (self aggregateHandlers
		collect: [ :aggregateHandler | aggregateHandler aggregate ]) asSet