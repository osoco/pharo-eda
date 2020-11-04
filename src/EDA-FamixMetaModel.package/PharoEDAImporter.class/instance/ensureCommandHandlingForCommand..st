public-entity-creation
ensureCommandHandlingForCommand: aEDACommandModel
	| commandHandling |
	^ commandHandlings
		at: aEDACommandModel
		ifAbsent: [commandHandling := self createCommandHandling: aEDACommandModel.
			self addEntity: commandHandling.
			commandHandling]