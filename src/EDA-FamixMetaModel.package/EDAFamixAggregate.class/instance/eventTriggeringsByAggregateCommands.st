accessing
eventTriggeringsByAggregateCommands
	^ self commandsToView
		flatCollect: [ :command | command eventTriggeringsByCommand ]