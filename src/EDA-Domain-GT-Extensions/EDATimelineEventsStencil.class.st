Class {
	#name : #EDATimelineEventsStencil,
	#superclass : #BrStencil,
	#instVars : [
		'events'
	],
	#category : 'EDA-Domain-GT-Extensions-Stencils'
}

{ #category : #'instance creation' }
EDATimelineEventsStencil class >> on: aCollectionOfEvents [
	^ self new events: aCollectionOfEvents 
]

{ #category : #'api - instantiation' }
EDATimelineEventsStencil >> create [
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
]

{ #category : #accessing }
EDATimelineEventsStencil >> events: anObject [
	events := anObject
]

{ #category : #accessing }
EDATimelineEventsStencil >> initialize [ 
	^ super initialize 
]
