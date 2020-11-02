public-entity-creation
createCommandHandling: aCommandClassModel 
	| handlingMethodModel aggregateRootClassModel |
	aggregateRootClassModel := aCommandClassModel aggregateRoot.
	handlingMethodModel := (Pragma allNamed: #useAsCommandHandlerFor: in: aggregateRootClassModel)
	select: [:pragma | pragma arguments = #(aCommandClassModel asSymbol)].
	
	^ EDAFamixCommandHandling new
		command: aCommandClassModel;
		aggregate: (self ensureAggregateForAggregateRootClass: handlingMethodModel class);
		handlerMethod: (self ensureMethod: handlingMethodModel);
		yourself