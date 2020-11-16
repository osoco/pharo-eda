public-entity-creation
createEventPublishing: anEDAEventModel
	| model eventPublishing aggregateRootClassModel aggregateRootClass applyMethods |
	model := anEDAEventModel event mooseModel.
	applyMethods := FAMIXMethodGroup new.
	"	aggregateRootClass := EDAAggregateRoot subclasses
		detect: [ :anAggregateRootClass | 
			anAggregateRootClass methodDict keys
				includesSubstringAnywhere: 'apply' , (anEDAEventModel name withoutPrefix: 'ATS') ]
		ifNone: [  ]."
	aggregateRootClass := anEDAEventModel event smalltalkClass
		aggregateRootClass.
	aggregateRootClass methodDict
		keysAndValuesDo: [ :methodName :method | 
			(methodName
				includesSubstring: 'apply' , (anEDAEventModel name withoutPrefix: 'ATS'))
				ifTrue: [ applyMethods add: (model methodModelFor: method) ] ].
	aggregateRootClass
		ifNotNil: [ aggregateRootClassModel := model classModelFor: aggregateRootClass.
			eventPublishing := EDAFamixEventPublishing new
				event: anEDAEventModel;
				aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
				applyMethods: applyMethods.
			eventPublishings at: anEDAEventModel put: eventPublishing ].
	^ eventPublishing