public-entity-creation
createCommandHandling: aEDACommandModel
	| handlingMethod aggregateRootClassModel aggregateClass commandClassModel commandClass commandHandling |
	commandClassModel := aEDACommandModel command.
	commandClass := commandClassModel smalltalkClass.
	"aggregateRootClassModel := commandClassModel aggregateRoot."
	aggregateClass := ((Class environment organization
		classesInCategory: commandClass category)
		select: [ :class | EDAAggregateRoot subclasses includes: class ])
		first.
	aggregateRootClassModel := self ensureClass: aggregateClass.
	handlingMethod := ((Pragma
		allNamed: #useAsCommandHandlerFor:
		in: aggregateClass)
		select: [ :pragma | pragma arguments first = commandClass name ])
		first method.
	commandHandling :=EDAFamixCommandHandling new
		command: aEDACommandModel;
		aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
		handlerMethod: (self ensureMethod: handlingMethod);
		yourself.
	commandHandlings at: aEDACommandModel put: commandHandling.
	^ commandHandling 