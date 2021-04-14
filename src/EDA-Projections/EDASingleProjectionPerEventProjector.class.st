Class {
	#name : #EDASingleProjectionPerEventProjector,
	#superclass : #EDAProjector,
	#traits : 'EDATErrorHelper',
	#classTraits : 'EDATErrorHelper classTrait',
	#category : #'EDA-Projections-Projectors'
}

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod [
	| result |
	result := self perform: aProjectionMethod selector with: anEvent with: aProjection.
	^ result
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod andThen: aBlock [
	| succeed |
	[ | eventToEmitClass eventToEmit |
	succeed := self
		delegateEventProjectionOf: anEvent
		in: aProjection
		to: aProjectionMethod.
	succeed
		ifTrue: [ aProjection updateLastProjectedEvent: anEvent timestamp ]
		ifFalse: [ aProjection addUnprojectedEvent: anEvent ].
	aProjection saveProjection.
	eventToEmitClass := succeed
		ifTrue: [ EDAEventProjected ]
		ifFalse: [ EDAEventNotProjected ].
	eventToEmit := eventToEmitClass new
		projection: aProjection class;
		event: anEvent.
	aBlock value: eventToEmit.
	eventToEmit emit ]
		on: Exception
		do: [ :exception | 
			succeed := self
				manageError: exception
				whenProjectingEvent: anEvent
				usingErrorStrategy: self class errorHandlingBehavior strategy ].
	^ succeed
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> iteratingBlock [
	^ [ :index :event :projection |  ]
]

{ #category : #handling }
EDASingleProjectionPerEventProjector >> manageError: anException for: aCommandOrEvent usingErrorStrategy: aStrategy [
	| errorHandler result context basename dictionary |
	errorHandler := (self class environment at: aStrategy asSymbol) new.
	errorHandler class shouldPersistFuel
		ifTrue: [ self
				logErrorMessage:
					'Error processing ' , aCommandOrEvent greaseString , ': '
						, anException description greaseString.
			context := thisContext clone.
			basename := self class basename.
			self
				writeFuelContext: context
				named: anException class greaseString
				withBasename: basename.
			self write: aCommandOrEvent withBasename: basename ].
	errorHandler context: context.
	dictionary := Dictionary new.
	dictionary at: #commandOrEvent put: aCommandOrEvent.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectEvent: anEvent usingEmittingBlock: aBlock [
	| projectionHandlers result |
	projectionHandlers := self
		retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty: [ self
				logDebugMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString
						, ') cannot be projected since projector '
						, self class greaseString , ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self
				logErrorMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString
						, ') will be projected twice in projection '
						, self class projectionClass greaseString , '.' ].
	projectionHandlers
		ifNotEmpty: [ :handlerCollection | 
			result := self retrieveProjectionForEvent: anEvent.
			result := result
				ifNil: [ self createNewProjectionForEvent: anEvent ] ].
	result
		ifNotNil: [ :projection | 
			projectionHandlers
				do: [ :projectionMethod | 
					self
						delegateEventProjectionOf: anEvent
						in: projection
						to: projectionMethod
						andThen: aBlock ] ].
	^ result
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock [
	^ self
		projectFilteredEvents: anEventCollection
		ofTenant: aTenant
		usingBlock: aBlock
		betweenEvents: self iteratingBlock
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock betweenEvents: iterationBlock [
	| projectionLogic |
	projectionLogic := [ :index :event |
	| aProjection |
	self
		logEvent: event id
		ofTenant: aTenant
		ofEventClass: event class
		atPosition: index
		ofTotal: anEventCollection size
		projectedIn: self class projectionClass.
	aProjection := self
		projectEvent: event
		atIndex: index
		ofTotalCount: anEventCollection size.
	aBlock value: aProjection value: event value: index.
	iterationBlock value: index value: event value: aProjection ].
	self class headlessMode
		ifTrue: [ anEventCollection keysAndValuesDo: projectionLogic ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: projectionLogic
				displayingProgress: [ :index :event |
					'Processing event ' , index greaseString , '/'
						, anEventCollection size greaseString , ' : '
						, event class greaseString , ' (' , event id greaseString , ')' ] ]
]

{ #category : #'projection retrieval' }
EDASingleProjectionPerEventProjector >> retrieveProjectionForEvent: anEvent [
	self subclassResponsibility
]
