public-entity-creation
createCommandHandling: anEDACommandModel
	| handlingMethod aggregateRootClassModel aggregateRootClass commandClassModel commandClass commandHandling pragma |
	commandClassModel := anEDACommandModel command.
	commandClass := commandClassModel smalltalkClass.
	"aggregateRootClassModel := commandClassModel aggregateRoot."
	aggregateRootClass := EDAAggregateRoot subclasses
		detect: [ :anAggregateRootClass | 
			pragma := (Pragma
				allNamed: #useAsCommandHandlerFor:
				in: anAggregateRootClass) detect: [ :aPragma | aPragma arguments first = commandClass name ] ifNone: [  ].
				pragma isNotNil  ]
		ifNone: [  ].
	aggregateRootClass
		ifNotNil: [ aggregateRootClassModel := self ensureClass: aggregateRootClass.
			handlingMethod := pragma method.
			commandHandling := EDAFamixCommandHandling new
				command: anEDACommandModel;
				aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
				handlerMethod: (self ensureMethod: handlingMethod);
				yourself.
			commandHandlings at: anEDACommandModel put: commandHandling ].
	^ commandHandling


	"aggregateRootClass := ((Class environment organization
		classesInCategory: commandClass category)
		select: [ :class | EDAAggregateRoot subclasses includes: class ])
		first.
	aggregateRootClassModel := self ensureClass: aggregateRootClass.
	handlingMethod := ((Pragma
		allNamed: #useAsCommandHandlerFor:
		in: aggregateRootClass)
		detect: [ :pragma | pragma arguments first = commandClass name ])
		method."