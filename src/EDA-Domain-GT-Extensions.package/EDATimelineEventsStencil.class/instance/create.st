api - instantiation
create
	<return: #Object>
	| eventsData aPlotter |
	eventsData := events
		collect: [ :event | event timestamp -> event className ].
	aPlotter := GtPlotter new.
	^ aPlotter verticalTimeline
		withProjectionAxis;
		timelineData: #key;
		projectionData: #value;
		timelineLabelFormat: [ :eachDateAndTime | 
			eachDateAndTime asRopedText glamorousRegularFontAndSize
				foreground: Color darkGray ];
		timelineFrom: events first timestamp - 4 days to: events last timestamp + 4 days;
		with: eventsData;
		yourself