Extension { #name : #EDAAggregateRoot }

{ #category : #'*EDA-Domain-GT-Extensions' }
EDAAggregateRoot >> gtViewEventsListFor: aView [
	<gtView>
	| events |
	events := self events ifEmpty: [ ^ aView empty ].
	^ aView explicit
		title: 'Events';
		priority: 10;
		stencil: (EDAColumnedListEventsStencil on: events);
		yourself
]

{ #category : #'*EDA-Domain-GT-Extensions' }
EDAAggregateRoot >> gtViewEventsTimelineFor: aView [
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
]
