initialization
setupProjection: aProjectionClass
	| projectionSourceEvents currentProjections lastProjectedEvent filteredProjectionSourceEvents projectedEvents |
	self logInfoMessage: 'Starting projections for projection: ' , aProjectionClass greaseString , '.'.
	projectionSourceEvents := aProjectionClass sourceEvents: self eventStore.
	(aProjectionClass isSynchronized: projectionSourceEvents)
		ifFalse: [ self flag: #TODO.	"configure different options in this case (abort, recreate, warning) via settings"
			currentProjections := aProjectionClass new selectManyWhere: Dictionary new.
			currentProjections ifEmpty: [ lastProjectedEvent := Date new ] ifNotEmpty: [ lastProjectedEvent := (currentProjections collect: [ :each | each lastProjectedEvent ]) asSortedCollection last ].
			self logInfoMessage: 'Last projected event: ' , lastProjectedEvent greaseString , '.'.
			filteredProjectionSourceEvents := (projectionSourceEvents select: [ :each | each timestamp > lastProjectedEvent ]) asSortedCollection: [ :i :j | i timestamp < j timestamp ].
			projectedEvents := Dictionary new.
			filteredProjectionSourceEvents
				doWithIndex: [ :event :index | 
					| aProjection |
					aProjection := event updateProjection: aProjectionClass.
					aProjection class = ATSApplicationsByContestIdProjection
						ifTrue: [ projectedEvents at: aProjection contestId put: aProjection numProjectedEvents.
							self flag: #TODO.	"clean this mess required to fix the number of projected events in case it is not incremented"
							projectedEvents values sum < index
								ifFalse: [ aProjection incProjectedEvents.
									aProjection updateLastProjectedEvent: event timestamp.
									aProjection saveProjection ] ].
					EDAEventProjected new
						projection: aProjectionClass;
						event: event;
						index: index;
						projectionSourceEventsSize: filteredProjectionSourceEvents size;
						emit ] ]