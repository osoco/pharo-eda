projection retrieval
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers projections |
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty: [ self
				logDebugMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString
						, ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self
				logErrorMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projections '
						, self projectionClass greaseString , '.' ].
	projectionHandlers
		ifNotEmpty: [ :ph | 
			projections := self retrieveProjectionsForEvent: anEvent.
			projections := projections ifEmpty: [ self createNewProjectionsForEvent: anEvent ] ].
	projectionHandlers
		do: [ :projectionMethod |
			self
				delegateEventProjectionOf: anEvent
				in: projections
				to: projectionMethod
				andThen: aBlock ].
	^ projections