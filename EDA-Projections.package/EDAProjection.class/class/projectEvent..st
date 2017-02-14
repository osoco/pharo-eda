projection
projectEvent: anEvent
	| projectionHandlers projectionHandlerMethodsForEvent |
	projectionHandlers := Pragma allNamed: #projectionForEvents: in: self class.
	projectionHandlerMethodsForEvent := projectionHandlers
		select: [ :pragma | pragma arguments first contains: [ :supportedEvent | supportedEvent asClass == anEvent class ] ]
		thenCollect: [ :pragma | pragma method ].
	projectionHandlerMethodsForEvent do: [ :projectionMethod | self perform: projectionMethod selector with: anEvent ]