initialization
setupProjections
	| projections projectionSourceEvents projectedEvents |
	projections := EDAProjection subclasses reject: [ :projectionClass | projectionClass name beginsWith: 'EDATest' ].
	Transcript
		print: 'Setting up ';
		print: (projections ifNil: [ '0 projections ' ] ifNotNil: [ :prjs | prjs size asString , ' projections ' ]);
		print: 'for this application...';
		cr;
		flush.
	projections
		do: [ :projection | 
			projectionSourceEvents := projection sourceEvents: self eventStore.
			(projection isSynchronized: projectionSourceEvents)
				ifFalse: [ self flag: #TODO.	"configure different options in this case (abort, recreate, warning) via settings"
					projection removeProjection.
					projectedEvents := Dictionary new.
					projectionSourceEvents
						doWithIndex: [ :event :index | 
							| aProjection |
							aProjection := event updateProjection: projection.
							projectedEvents at: aProjection contestId put: aProjection numProjectedEvents.
							"self haltIf: [ (projectedEvents values sum = index) not ]."
							self flag: #TODO. "clean this mesh required to fix the number of projected events in case it is not incremented"
							projectedEvents values sum = index
								ifFalse: [ aProjection incProjectedEvents.
									aProjection saveProjection ].
							EDAEventProjected new
								projection: projection;
								event: event;
								index: index;
								projectionSourceEventsSize: projectionSourceEvents size;
								emit ] ] ]