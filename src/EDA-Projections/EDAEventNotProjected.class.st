Class {
	#name : #EDAEventNotProjected,
	#superclass : #EDAProjectionLogEvent,
	#instVars : [
		'index',
		'projectionSourceEventsSize',
		'event'
	],
	#category : 'EDA-Projections-Events'
}

{ #category : #protected }
EDAEventNotProjected class >> successOutcome [
	^ false
]

{ #category : #accessing }
EDAEventNotProjected >> event [
	^ event
]

{ #category : #accessing }
EDAEventNotProjected >> event: anEvent [
	event := anEvent copy
]

{ #category : #accessing }
EDAEventNotProjected >> index [
	^ index
]

{ #category : #accessing }
EDAEventNotProjected >> index: anObject [
	index := anObject
]

{ #category : #accessing }
EDAEventNotProjected >> projectionSourceEventsSize [
	^ projectionSourceEventsSize
]

{ #category : #accessing }
EDAEventNotProjected >> projectionSourceEventsSize: anInteger [
	projectionSourceEventsSize := anInteger
]
