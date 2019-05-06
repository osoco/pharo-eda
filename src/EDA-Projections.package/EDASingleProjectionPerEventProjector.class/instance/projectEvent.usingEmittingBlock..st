projecting
projectEvent: anEvent usingEmittingBlock: aBlock
	| projectionHandlers result |
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty: [ self
				logDebugMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString
						, ' doesn''t support it.' ].
	projectionHandlers size > 1
		ifTrue: [ self
				logErrorMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projection '
						, self class projectionClass greaseString , '.' ].
	projectionHandlers
		ifNotEmpty: [ :handlerCollection | 
			result := self retrieveProjectionForEvent: anEvent.
			result := result ifNil: [ self createNewProjectionForEvent: anEvent ] ].
	result
		ifNotNil: [ :projection | 
			projectionHandlers
				do: [ :projectionMethod | 
					self
						delegateEventProjectionOf: anEvent
						in: projection
						to: projectionMethod
						andThen: aBlock ] ].
	^ result