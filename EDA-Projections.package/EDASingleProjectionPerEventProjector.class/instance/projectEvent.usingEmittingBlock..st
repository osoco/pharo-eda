projecting
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers projection |
	projection := self retrieveProjectionForEvent: anEvent.
	projection := projection ifNil: [ self createNewProjectionForEvent: anEvent ].
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		do: [ :projectionMethod |
			self
				delegateEventProjectionOf: anEvent
				in: projection
				to: projectionMethod
				andThen: aBlock ].
	^ projection