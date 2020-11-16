public-entity-creation
ensureCommandForCommandClass: aCommandClassModel
	| command |
	^ commands
		at: aCommandClassModel
		ifAbsent: [ command := self createCommand: aCommandClassModel.
			self addEntity: command.
			self ensureCommandHandlingForCommand: command.
			self ensureEventTriggeringForCommand: command.
			command ]