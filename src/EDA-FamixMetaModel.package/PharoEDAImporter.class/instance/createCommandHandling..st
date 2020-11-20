public-entity-creation
createCommandHandling: anEDACommandModel
	| model handlingMethodModel aggregateRootClassModel aggregateRootClass commandClassModel commandClass commandHandling pragma |
	model := anEDACommandModel commandClassModel mooseModel.
	commandClassModel := anEDACommandModel commandClassModel.
	commandClass := commandClassModel smalltalkClass.
	"Obtener aggregateRootClass así y pragma directamente sin detect?
	aggregateRootClass := commandClass aggregateRootClass.
	"
	aggregateRootClass := EDAAggregateRoot subclasses
		detect: [ :anAggregateRootClass | 
			pragma := (Pragma
				allNamed: #useAsCommandHandlerFor:
				in: anAggregateRootClass)
				detect: [ :aPragma | aPragma arguments first = commandClass name ]
				ifNone: [  ].
			pragma isNotNil ]
		ifNone: [  ].
	aggregateRootClass
		ifNotNil: [ aggregateRootClassModel := model classModelFor: aggregateRootClass.
			handlingMethodModel := model methodModelFor: pragma method.
			commandHandling := EDAFamixCommandHandling new
				command: anEDACommandModel;
				aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
				handlerMethod: handlingMethodModel;
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