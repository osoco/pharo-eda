Class {
	#name : #EDAProjectionSynchronizationChecked,
	#superclass : #EDAProjectionLogEvent,
	#instVars : [
		'synchronized',
		'projectionSourceEventsSize',
		'totalProjectedEventsSize'
	],
	#category : 'EDA-Projections-Events'
}

{ #category : #protected }
EDAProjectionSynchronizationChecked class >> successOutcome [
	^ true
]

{ #category : #printing }
EDAProjectionSynchronizationChecked >> printOn: stream [
	self synchronized
		ifFalse: [ stream << '[WARNING] ' ].
	stream
		<< 'Projection ';
		print: self projection greaseString.
	self synchronized
		ifTrue: [ stream << ' seems synchronized' ]
		ifFalse: [ stream << ' seems NOT synchronized ' ].
	stream
		<< ' with ';
		print: self totalProjectedEventsSize;
		<< ' of ';
		print: self projectionSourceEventsSize;
		<< ' total event(s).'
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> projectionSourceEventsSize [
	^ projectionSourceEventsSize
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> projectionSourceEventsSize: anObject [
	projectionSourceEventsSize := anObject
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> synchronized [
	^ synchronized
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> synchronized: anObject [
	synchronized := anObject
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> totalProjectedEventsSize [
	^ totalProjectedEventsSize
]

{ #category : #accessing }
EDAProjectionSynchronizationChecked >> totalProjectedEventsSize: anObject [
	totalProjectedEventsSize := anObject
]
