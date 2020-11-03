public-entity-creation
createCommandHandling: aEDACommandModel
	| handlingMethod aggregateRootClassModel aggregateClass commandClassModel commandClass |
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
	^ EDAFamixCommandHandling new
		command: aEDACommandModel;
		aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
		handlerMethod: (self ensureMethod: handlingMethod);
		yourself