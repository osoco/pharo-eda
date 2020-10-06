*EDA-Domain-GT-Extensions
gtViewEventsTimelineFor: aView
	<gtView>
	| events |
	events := self events ifEmpty: [ ^ aView empty ].
	^ aView explicit
		title: 'Timeline of events';
		priority: 30;
		disableAsync;
		stencil: [ | eventsData aPlotter |
			eventsData := events
				collect: [ :event | event timestamp -> event className ].
			aPlotter := GtPlotter new.
			aPlotter verticalTimeline
				withProjectionAxis;
				timelineData: #key;
				projectionData: #value;
				timelineLabelFormat: [ :eachDateAndTime | 
					eachDateAndTime asRopedText glamorousRegularFontAndSize
						foreground: Color darkGray ];
				timelineFrom: events first timestamp - 4 days
					to: DateAndTime now;
				with: eventsData;
				yourself ]