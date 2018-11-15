projection retrieval
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers projections |
	projections := self retrieveProjectionsForEvent: anEvent.
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		do: [ :projectionMethod |
			self
				delegateEventProjectionOf: anEvent
				in: projections
				to: projectionMethod
				andThen: aBlock ].
	^ projections