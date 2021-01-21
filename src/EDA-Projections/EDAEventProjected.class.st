Class {
	#name : #EDAEventProjected,
	#superclass : #EDAProjectionLogEvent,
	#instVars : [
		'index',
		'projectionSourceEventsSize',
		'event'
	],
	#category : 'EDA-Projections-Events'
}

{ #category : #protected }
EDAEventProjected class >> successOutcome [
	^ true
]

{ #category : #accessing }
EDAEventProjected >> event [
	^ event
]

{ #category : #accessing }
EDAEventProjected >> event: anEvent [
	event := anEvent copy
]

{ #category : #accessing }
EDAEventProjected >> index [
	^ index
]

{ #category : #accessing }
EDAEventProjected >> index: anObject [
	index := anObject
]

{ #category : #accessing }
EDAEventProjected >> projectionSourceEventsSize [
	^ projectionSourceEventsSize
]

{ #category : #accessing }
EDAEventProjected >> projectionSourceEventsSize: anInteger [
	projectionSourceEventsSize := anInteger
]
