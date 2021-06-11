Class {
	#name : #EDATestEventStub,
	#superclass : #Object,
	#traits : 'EDATTestEvent',
	#classTraits : 'EDATTestEvent classTrait',
	#category : #'EDA-TestSupport'
}

{ #category : #testing }
EDATestEventStub class >> isEventGenerated: attr [
	^ EDAEventSourcingEvent isEventGenerated: attr
]
