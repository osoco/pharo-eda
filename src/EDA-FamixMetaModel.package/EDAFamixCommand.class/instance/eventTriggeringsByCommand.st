as yet unclassified
eventTriggeringsByCommand
	^ (self eventTriggerings
		collect: [ :eventTriggering | eventTriggering event ]) asSet