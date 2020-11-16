view
gtCommandsEventsFor: aView
	<gtView>
	| commands events elements view |
	commands := self commands.
	events := self events.
	elements := (Set new
		add: self;
		yourself) , events , commands.
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
		with: elements.
	view edges
		shape: [ BlLineElement new
				border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
				constraintsDo: [ :c | c ignoredByLayout ];
				zIndex: -1;
				toHead:
					(BlArrowheadSimpleArrow new
						border:
							(BlBorder builder
								paint: (Color gray alpha: 0.4);
								width: 6;
								build)) ];
		fromCenterBottom;
		toCenterTop;
		connectToAll: [ :element | 
			element class = self class
				ifTrue: [ element events ]
				ifFalse: [ #() ] ];
		connectFromAll: [ :element | 
			element class = self class
				ifTrue: [ element commands ]
				ifFalse: [ #() ] ].
	view layout force charge: -1000.
	"	view layout custom: GtGradHorizontalDominanceCenteredTreeLayout new."
	^ aView mondrian
		title: 'Commands & Events';
		priority: 40;
		initialize: view