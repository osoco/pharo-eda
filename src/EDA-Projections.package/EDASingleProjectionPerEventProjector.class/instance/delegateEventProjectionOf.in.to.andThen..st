projecting
delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod andThen: aBlock
	| succeed |
	[ | eventToEmitClass eventToEmit |
	succeed := self
		delegateEventProjectionOf: anEvent
		in: aProjection
		to: aProjectionMethod.
	succeed
		ifTrue: [ aProjection updateLastProjectedEvent: anEvent timestamp ]
		ifFalse: [ aProjection addUnprojectedEvent: anEvent ].
	aProjection saveProjection.
	eventToEmitClass := succeed
		ifTrue: [ EDAEventProjected ]
		ifFalse: [ EDAEventNotProjected ].
	eventToEmit := eventToEmitClass new
		projection: aProjection class;
		event: anEvent.
	aBlock value: eventToEmit.
	eventToEmit emit ]
		on: Exception
		do: [ :exception | 
			succeed := self
				manageError: exception
				whenProjectingSingle: aProjection
				event: anEvent
				usingErrorStrategy: self class errorStrategy ].
	^ succeed