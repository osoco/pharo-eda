*EDA-Domain-GT-Extensions
gtViewEventsTimelineFor: aView
	<gtView>
	| events |
	events := self events.
	events ifEmpty: [ ^ aView empty ].
	^ aView explicit
		title: 'Timeline of Events';
		priority: 30;
		disableAsync;
		stencil: (EDATimelineEventsStencil on: events);
		yourself