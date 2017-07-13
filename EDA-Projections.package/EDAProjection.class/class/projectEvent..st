projection
projectEvent: anEvent
	| projectionHandlers projectionHandlerMethodsForEvent aProjection |
	projectionHandlers := Pragma
		allNamed: #projectionForEvents:
		in: self class.
	projectionHandlerMethodsForEvent := projectionHandlers
		select: [ :pragma |
			pragma arguments first
				anySatisfy: [ :supportedEvent | supportedEvent = anEvent class name ] ]
		thenCollect: [ :pragma | pragma method ].
	projectionHandlerMethodsForEvent
		do: [ :projectionMethod |
			[aProjection := self perform: projectionMethod selector with: anEvent.
			aProjection incProjectedEvents.
			aProjection saveProjection.] 
		on: Exception do: [ :exception | 
			Transcript
				print: 'WARNING: Projection of event failed with error ';
				print: exception description;
				cr
			].
 ]