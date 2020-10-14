projecting
delegateEventProjectionOf: anEvent in: aProjectionCollection to: aProjectionMethod andThen: aBlock
	| succeed |
	[ succeed := self
		perform: aProjectionMethod selector
		with: anEvent
		with: aProjectionCollection.
	aProjectionCollection
		do: [ :projection | 
			| eventToEmit |
			eventToEmit := self
				finishUpProjection: projection
				forEvent: anEvent
				withOutcome: succeed.
			aBlock value: eventToEmit.
			eventToEmit emit ] ]
		on: Error
		do: [ :exception | 
			succeed := self
				manageError: exception
				whenProjectingEvent: anEvent
				usingErrorStrategy: self class errorHandlingBehavior strategy ].
	^ succeed