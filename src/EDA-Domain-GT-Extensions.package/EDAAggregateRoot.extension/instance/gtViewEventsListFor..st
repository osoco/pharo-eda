*EDA-Domain-GT-Extensions
gtViewEventsListFor: aView
	<gtView>
	| events |
	events := self events ifEmpty: [ ^ aView empty ].
	^ aView explicit
		title: 'Events';
		priority: 10;
		stencil: (EDAColumnedListEventsStencil on: events);
		yourself