initialization
setupProjections
	| projections projectionSourceEvents |
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
				ifFalse: [
					self flag: #TODO.	"configure different options in this case (abort, recreate, warning) via settings"
					projection removeProjection.
					projectionSourceEvents
						doWithIndex: [ :event :index |
							event updateProjection: projection.
							EDAEventProjected new
								projection: projection;
								event: event;
								index: index;
								projectionSourceEventsSize: projectionSourceEvents size;
								emit ] ] ]