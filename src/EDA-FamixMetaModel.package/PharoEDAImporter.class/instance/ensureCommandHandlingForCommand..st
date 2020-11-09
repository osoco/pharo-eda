public-entity-creation
ensureCommandHandlingForCommand: anEDACommandModel
	| commandHandling |
	^ commandHandlings
		at: anEDACommandModel
		ifAbsent: [ commandHandling := self createCommandHandling: anEDACommandModel.
			commandHandling ifNotNil: [ self addEntity: commandHandling ].
			commandHandling ]