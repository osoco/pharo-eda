projection retrieval
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers projections |
	projections := self retrieveProjectionsForEvent: anEvent.
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty: [ self logErrorMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString , ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self logErrorMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projections ' , self projectionClass greaseString , '.' ].
	projectionHandlers
		do: [ :projectionMethod | 
			self
				delegateEventProjectionOf: anEvent
				in: projections
				to: projectionMethod
				andThen: aBlock ].
	^ projections