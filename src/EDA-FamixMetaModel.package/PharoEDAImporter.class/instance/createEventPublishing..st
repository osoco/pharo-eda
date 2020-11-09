public-entity-creation
createEventPublishing: anEDAEventModel
	| eventPublishing aggregateRootClassModel aggregateRootClass applyMethods |
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
				ifTrue: [ applyMethods add: (self ensureMethod: method) ] ].
	aggregateRootClass
		ifNotNil: [ aggregateRootClassModel := self ensureClass: aggregateRootClass.
			eventPublishing := EDAFamixEventPublishing new
				event: anEDAEventModel;
				aggregate: (self ensureAggregateForAggregateRootClass: aggregateRootClassModel);
				applyMethods: applyMethods yourself.
			eventPublishings at: anEDAEventModel put: eventPublishing ].
	^ eventPublishing