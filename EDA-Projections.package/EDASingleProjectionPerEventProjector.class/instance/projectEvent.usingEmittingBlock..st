projecting
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers projection |
	projection := self retrieveProjectionForEvent: anEvent.
	projection := projection ifNil: [ self createNewProjectionForEvent: anEvent ].
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers ifEmpty: [ 
		self logErrorMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString , ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self logErrorMessage: 'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projection ' , self projectionClass greaseString , '.' ].
	projectionHandlers
		do: [ :projectionMethod | 
			self
				delegateEventProjectionOf: anEvent
				in: projection
				to: projectionMethod
				andThen: aBlock ].
	^ projection