view
gtCommandsAggregatesEventsFor: aView
	<gtView>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			| colors |
			colors := {(#EDAFamixCommand -> Color green).
			(#EDAFamixAggregate -> Color red).
			(#EDAFamixEvent -> Color yellow)} asDictionary.
			BlElement new
				geometry: BlEllipse new;
				background: (colors at: x className);
				border: (BlBorder paint: Color black);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: self elementsToView.
	view edges
		shape: [ :object | object edgeStencil ];
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
		title: 'Commands & Aggregates & Events';
		priority: 40;
		initialize: view