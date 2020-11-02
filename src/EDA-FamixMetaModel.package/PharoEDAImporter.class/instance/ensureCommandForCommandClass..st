public-entity-creation
ensureCommandForCommandClass: aCommandClassModel
	| command commandHandling |
	^ commands
		at: aCommandClassModel
		ifAbsent: [ command := self createCommand: aCommandClassModel.
			self addEntity: command.
			commandHandling := self createCommandHandling: command.
			self addEntity: commandHandling.
			command ]