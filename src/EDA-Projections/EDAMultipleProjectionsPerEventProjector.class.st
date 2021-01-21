Class {
	#name : #EDAMultipleProjectionsPerEventProjector,
	#superclass : #EDAProjector,
	#traits : 'EDATLogging + EDATErrorHelper',
	#classTraits : 'EDATLogging classTrait + EDATErrorHelper classTrait',
	#category : 'EDA-Projections-Projectors'
}

{ #category : #'projection creation' }
EDAMultipleProjectionsPerEventProjector >> createMissingProjections: aCollection forEvent: anEvent [
	self subclassResponsibility
]

{ #category : #projecting }
EDAMultipleProjectionsPerEventProjector >> delegateEventProjectionOf: anEvent in: aProjectionCollection to: aProjectionMethod andThen: aBlock [
	| succeed |
	[ succeed := self
		perform: aProjectionMethod selector
		with: anEvent
		with: aProjectionCollection.
	aProjectionCollection
		do: [ :projection | 
			| eventToEmit |
			eventToEmit := self
				finishUpProjection: projection
				forEvent: anEvent
				withOutcome: succeed.
			aBlock value: eventToEmit.
			eventToEmit emit ] ]
		on: Error
		do: [ :exception | 
			succeed := self
				manageError: exception
				whenProjectingEvent: anEvent
				usingErrorStrategy: self class errorHandlingBehavior strategy ].
	^ succeed
]

{ #category : #projecting }
EDAMultipleProjectionsPerEventProjector >> finishUpProjection: aProjection forEvent: anEvent withOutcome: aBoolean [
	| eventToEmitClass result |
	aBoolean
		ifTrue: [ aProjection updateLastProjectedEvent: anEvent timestamp ]
		ifFalse: [ aProjection addUnprojectedEvent: anEvent ].
	aProjection saveProjection.
	eventToEmitClass := aBoolean
		ifTrue: [ EDAEventProjected ]
		ifFalse: [ EDAEventNotProjected ].
	result := eventToEmitClass new
		projection: aProjection class;
		event: anEvent.
	^ result
]

{ #category : #projecting }
EDAMultipleProjectionsPerEventProjector >> projectEvent: anEvent usingEmittingBlock: aBlock [
	| projectionHandlers projections |
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty:
			[ self logDebugMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString , ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self logErrorMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projections ' , self projectionClass greaseString , '.' ].
	projectionHandlers
		ifNotEmpty: [ :ph | 
			projections := self retrieveProjectionsForEvent: anEvent.
			projections := self createMissingProjections: projections forEvent: anEvent ].
	projectionHandlers
		do: [ :projectionMethod | 
			self
				delegateEventProjectionOf: anEvent
				in: projections
				to: projectionMethod
				andThen: aBlock ].
	^ projections
]

{ #category : #'projection retrieval' }
EDAMultipleProjectionsPerEventProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock [
	| projectionLogic |
	projectionLogic := [ :index :event |
	| aProjectionCollection |
	self
		logEvent: event id
		ofTenant: event tenant
		ofEventClass: event class
		atPosition: index
		ofTotal: anEventCollection size
		projectedIn: self class projectionClass.
	aProjectionCollection := self
		projectEvent: event
		atIndex: index
		ofTotalCount: anEventCollection size.
	aBlock value: aProjectionCollection value: event value: index ].
	self class headlessMode
		ifTrue: [ anEventCollection keysAndValuesDo: projectionLogic ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: projectionLogic
				displayingProgress: [ :index :event |
					'Processing event ' , index greaseString , '/'
						, anEventCollection size greaseString , ' : '
						, event class name greaseString , ' (' , event id greaseString
						, ')' ] ]
]

{ #category : #'projection retrieval' }
EDAMultipleProjectionsPerEventProjector >> retrieveProjectionsForEvent: anEvent [
	self subclassResponsibility
]
