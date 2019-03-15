projecting
finishUpProjection: aProjection forEvent: anEvent withOutcome: aBoolean
	| eventToEmitClass result |
	aBoolean
		ifTrue: [ aProjection updateLastProjectedEvent: anEvent timestamp ]
		ifFalse: [ aProjection addUnprojectedEvent: anEvent ].
	aProjection saveProjection.
	eventToEmitClass := aBoolean
		ifTrue: [ EDAEventProjected ]
		ifFalse: [ EDAEventNotProjected ].
	result := eventToEmitClass new
		projection: aProjection class;
		event: anEvent.
	^ result