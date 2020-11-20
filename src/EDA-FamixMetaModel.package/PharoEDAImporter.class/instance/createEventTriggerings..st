public-entity-creation
createEventTriggerings: anEDACommandModel
	| model handlingMethodModel aggregateRootClass aggregateRootClassModel commandClassModel commandClass allEventTriggeringsForCommand pragma eventTriggereds analyzedMethods findDirectEventForMethod |
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
			eventTriggereds := Set new.
			analyzedMethods := Set new.
			findDirectEventForMethod := [ :method | 
			analyzedMethods add: method.
			(method queryAll: #out) opposites
				do: [ :each | 
					each class = FAMIXClass
						ifTrue: [ each isEvent
								ifTrue: [ eventTriggereds
										add: (self ensureEventForEventSourcingEventClass: each) ] ].
					each class = FAMIXMethod
						ifTrue: [ (analyzedMethods includes: each)
								ifFalse: [ findDirectEventForMethod value: each ] ] ] ].
			findDirectEventForMethod value: handlingMethodModel.
			allEventTriggeringsForCommand := eventTriggereds
				collect: [ :eventTriggered | 
					EDAFamixEventTriggering new
						command: anEDACommandModel;
						aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
						event: eventTriggered;
						yourself ].
			eventTriggerings
				at: anEDACommandModel
				put: allEventTriggeringsForCommand ].
	^ allEventTriggeringsForCommand