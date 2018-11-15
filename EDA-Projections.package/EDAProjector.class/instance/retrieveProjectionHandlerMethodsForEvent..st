helper
retrieveProjectionHandlerMethodsForEvent: anEvent
	| result projectionHandlers |
	projectionHandlers := Pragma allNamed: #projectionForEvents: in: self class.
	result := projectionHandlers
		select: [ :pragma | pragma arguments first anySatisfy: [ :supportedEvent | supportedEvent = anEvent class name ] ]
		thenCollect: [ :pragma | pragma method ].
		^ result