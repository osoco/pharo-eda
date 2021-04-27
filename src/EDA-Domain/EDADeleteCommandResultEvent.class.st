Class {
	#name : #EDADeleteCommandResultEvent,
	#superclass : #EDACommandResultEvent,
	#category : #'EDA-Domain-Events'
}

{ #category : #'generated-v1' }
EDADeleteCommandResultEvent class >> ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs [
	| result |
	result := super ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs.
	result timestamp: DateAndTime now asUTC.
	^ result
]

{ #category : #initialization }
EDADeleteCommandResultEvent >> initialize [
	super initialize.
	self delete: true
]

{ #category : #messaging }
EDADeleteCommandResultEvent >> routingKey [
	^ (EDAMessageSerializer nameWithoutPrefixForMessageClass: self aggregateRootClass) asLowercase , '.deleted'
]
