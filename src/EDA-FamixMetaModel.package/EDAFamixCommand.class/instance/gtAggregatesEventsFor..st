gt - viewers
gtAggregatesEventsFor: aView
	<gtView>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :object | object defaultElementStencil ];
		with: self elementsToView;
		forEach: [ :object | 
			object class = EDAFamixAggregate 
				ifTrue: [ view nodes
						shape: [ :anAggregateElement | anAggregateElement defaultElementStencil ];
						with: object aggregateElementsToView ] ].
	view edges
		shape: [ :object | object defaultEdgeStencil ];
		fromCenterBottom;
		toCenterTop;
		connect: self aggregatesToView
			toAll: [ :anAggregate | anAggregate eventPublishingsByAggregate ];
		connect: self aggregatesToView
			fromAll: [ :anAggregate | anAggregate commandHandlingsByAggregate ];
		connect: self commandsToView
			toAll: [ :aCommand | aCommand eventTriggeringsByCommand ].
	view layout force charge: -1000.
	"	view layout custom: GtGradHorizontalDominanceCenteredTreeLayout new."
	^ aView mondrian
		title: 'Aggregates & Events';
		priority: 40;
		initialize: view