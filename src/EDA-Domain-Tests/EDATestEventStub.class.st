Class {
	#name : #EDATestEventStub,
	#superclass : #Object,
	#traits : 'EDATTestEvent',
	#classTraits : 'EDATTestEvent classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #testing }
EDATestEventStub class >> isEventGenerated: attr [
	^ EDAEventSourcingEvent isEventGenerated: attr
]
