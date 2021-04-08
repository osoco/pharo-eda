Class {
	#name : #EDAVersionedEvent,
	#superclass : #EDAEventSourcingEvent,
	#category : #'EDA-Events-Events'
}

{ #category : #'instance creation' }
EDAVersionedEvent class >> forEvent: anEvent andVersion: aVersion [
	self flag: #TODO.	"Sorry!"
	anEvent aggregateRootVersion: aVersion.
	^ anEvent
]
