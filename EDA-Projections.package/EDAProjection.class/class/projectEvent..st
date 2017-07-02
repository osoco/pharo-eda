projection
projectEvent: anEvent
	| projectionHandlers projectionHandlerMethodsForEvent aProjection |
	projectionHandlers := Pragma
		allNamed: #projectionForEvents:
		in: self class.
	projectionHandlerMethodsForEvent := projectionHandlers
		select: [ :pragma |
			pragma arguments first
				contains: [ :supportedEvent | supportedEvent asClass == anEvent class ] ]
		thenCollect: [ :pragma | pragma method ].
	projectionHandlerMethodsForEvent
		do: [ :projectionMethod |
			aProjection := self perform: projectionMethod selector with: anEvent.
			aProjection incProjectedEvents.
			aProjection saveProjection.
 ]