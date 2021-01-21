Class {
	#name : #EDAProjectionLogEvent,
	#superclass : #EDALogEvent,
	#instVars : [
		'projection',
		'tenant'
	],
	#category : 'EDA-Projections-Events'
}

{ #category : #protected }
EDAProjectionLogEvent class >> successOutcome [
	self subclassResponsibility 
]

{ #category : #printing }
EDAProjectionLogEvent >> printOn: stream [
	| indexPart outcomePart |
	indexPart := self index ifNil: [ '' ] ifNotNil: [ :i | '[' , i greaseString , '/' , self projectionSourceEventsSize greaseString , ']' ].
	outcomePart := self class successOutcome
		ifTrue: [ '' ]
		ifFalse: [ ' NOT' ].
	stream
		<< 'Event ';
		<< indexPart;
		print: self event class name;
		<< '(';
		<< self event uniqueId greaseString;
		<< ')';
		<< outcomePart;
		<< ' projected to ';
		print: self projection name
]

{ #category : #accessing }
EDAProjectionLogEvent >> projection [
	^ projection
]

{ #category : #accessing }
EDAProjectionLogEvent >> projection: aProjection [
	projection := aProjection copy
]

{ #category : #accessing }
EDAProjectionLogEvent >> tenant [
	^ tenant
]

{ #category : #accessing }
EDAProjectionLogEvent >> tenant: aTenant [
	tenant := aTenant
]
