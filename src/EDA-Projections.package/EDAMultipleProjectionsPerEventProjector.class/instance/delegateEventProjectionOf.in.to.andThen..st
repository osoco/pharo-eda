projecting
delegateEventProjectionOf: anEvent in: aProjectionCollection to: aProjectionMethod andThen: aBlock
	| succeed |
	[ | eventToEmitClass eventToEmit |
	succeed := self perform: aProjectionMethod selector with: anEvent with: aProjectionCollection.
	aProjectionCollection
		do: [ :projection | 
			succeed
				ifTrue: [
					projection updateLastProjectedEvent: anEvent timestamp ]
				ifFalse: [ projection addUnprojectedEvent: anEvent ].
			projection saveProjection.
			eventToEmitClass := succeed
				ifTrue: [ EDAEventProjected ]
				ifFalse: [ EDAEventNotProjected ].
			eventToEmit := eventToEmitClass new
				projection: projection class;
				event: anEvent.
			aBlock value: eventToEmit.
			eventToEmit emit ] ]
		on: Exception
		do: [ :exception | 
			succeed := self
				manageProjectingError: exception
				withEvent: anEvent
				andProjections: aProjectionCollection
				usingErrorStrategy: EDAProjector errorStrategy ].
	^ succeed