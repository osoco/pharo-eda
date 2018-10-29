projection
projectEvent: anEvent
	| projectionHandlers projectionHandlerMethodsForEvent projections |
	projectionHandlers := Pragma allNamed: #projectionForEvents: in: self class.
	projectionHandlerMethodsForEvent := projectionHandlers
		select: [ :pragma | pragma arguments first anySatisfy: [ :supportedEvent | supportedEvent = anEvent class name ] ]
		thenCollect: [ :pragma | pragma method ].
	projectionHandlerMethodsForEvent
		do: [ :projectionMethod | 
			[ projections := self perform: projectionMethod selector with: anEvent ]
				on: Exception
				do: [ :exception | 
					self logWarningMessage: 'Projection of event failed with error ', exception description, '.'].
			projections ifNotNil: [
				 projections do: [ :prj | 
					prj incProjectedEvents .
					prj updateLastProjectedEvent: anEvent timestamp .
					prj saveProjection .
				] 
			]
		].
	^ projections