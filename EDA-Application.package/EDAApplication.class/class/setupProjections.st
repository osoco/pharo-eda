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
			projectionSourceEvents := projection sourceEvents: EDAMongoEventStore new.	"self eventStore"
			projectionSourceEvents size > projection totalProjectedEvents
				ifFalse: [ Transcript
						print: 'Projection ';
						print: projection class name;
						print: ' seems synchronized with ';
						print: projection totalProjectedEvents;
						print: ' projected events';
						cr;
						flush ]
				ifTrue: [ Transcript
						print: '[WARNING] Projection ';
						print: projection class name;
						print: ' seems NOT synchronized with ';
						print: projection totalProjectedEvents;
						print: ' projected events';
						print: ' of ';
						print: projectionSourceEvents size;
						print: ' total source events';
						cr;
						flush.
					self flag: #TODO.	"configure options (abort, recreate, warning) via settings"
					Transcript
						print: 'Removing projection ';
						print: projection class name;
						cr;
						flush.
					projection removeProjection.
					Transcript
						print: 'Creating projection ';
						print: projection class name;
						cr;
						flush.
					projectionSourceEvents
						doWithIndex: [ :event :index |
							Transcript
								print: 'Projecting event ';
								print: index;
								print: '/';
								print: projectionSourceEvents size;
								print: ' to ';
								print: projection class name;
								cr;
								flush.
							event updateProjection: projection ] ] ]