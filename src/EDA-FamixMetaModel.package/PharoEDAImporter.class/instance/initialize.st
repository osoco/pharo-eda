public-entity-creation
initialize
	super initialize.
	aggregates := IdentityDictionary new.
	commands := IdentityDictionary new.
	events := IdentityDictionary new.
	commandHandlings := IdentityDictionary new.
		eventTriggerings  := IdentityDictionary new.
	eventPublishings := IdentityDictionary new.