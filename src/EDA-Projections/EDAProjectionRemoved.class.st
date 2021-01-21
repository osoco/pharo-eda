Class {
	#name : #EDAProjectionRemoved,
	#superclass : #EDAProjectionLogEvent,
	#category : 'EDA-Projections-Events'
}

{ #category : #protected }
EDAProjectionRemoved class >> successOutcome [
	^ true
]

{ #category : #printing }
EDAProjectionRemoved >> printOn: stream [
	stream
		<< 'Projection ';
		print: self projection name;
		<< ' removed'
]
