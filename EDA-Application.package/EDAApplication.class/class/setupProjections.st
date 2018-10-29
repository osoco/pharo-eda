initialization
setupProjections
	| projectionsClasses projectionSourceEvents filteredProjectionSourceEvents projectedEvents lastProjectedEvent currentProjections |
	projectionsClasses := EDAProjection subclasses reject: [ :projectionClass | projectionClass name beginsWith: 'EDATest' ].
	self logInfoMessage: 'Setting up ' , (projectionsClasses ifNil: [ '0 projections' ] ifNotNil: [ :prjs | prjs size asString , ' projections' ]) , ' for this application...'.
	projectionsClasses
		do: [ :projectionClass | 
			self logInfoMessage: 'Starting projections for projection: ' , projectionClass , '.'.
			projectionSourceEvents := projectionClass sourceEvents: self eventStore.
			(projectionClass isSynchronized: projectionSourceEvents)
				ifFalse: [ self flag: #TODO.	"configure different options in this case (abort, recreate, warning) via settings"
					currentProjections := projectionClass new selectManyWhere: Dictionary new.
					currentProjections ifEmpty: [ lastProjectedEvent := Date new ] ifNotEmpty: [ lastProjectedEvent := (currentProjections collect: [ :each | each lastProjectedEvent ]) asSortedCollection last ].
					self logInfoMessage: 'Last projected event: ', lastProjectedEvent, '.'.
					filteredProjectionSourceEvents := (projectionSourceEvents select: [ :each | each timestamp > lastProjectedEvent ]) asSortedCollection: [ :i :j | i timestamp < j timestamp ].
					projectedEvents := Dictionary new.
					filteredProjectionSourceEvents
						doWithIndex: [ :event :index | 
							| aProjection |
							aProjection := event updateProjection: projectionClass.
							aProjection class = ATSApplicationsByContestIdProjection
								ifTrue: [ projectedEvents at: aProjection contestId put: aProjection numProjectedEvents.
									self flag: #TODO.	"clean this mesh required to fix the number of projected events in case it is not incremented"
									projectedEvents values sum < index
										ifFalse: [ aProjection incProjectedEvents.
											aProjection updateLastProjectedEvent: event timestamp.
											aProjection saveProjection ] ].
							EDAEventProjected new
								projection: projectionClass;
								event: event;
								index: index;
								projectionSourceEventsSize: filteredProjectionSourceEvents size;
								emit ] ] ]