api
findById: anId
	| result events criteria aggregateClass |
	aggregateClass := self aggregateRootClass.
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	events := self eventStore findEventsOfAggregate: ATSApplicant whereCriteria: criteria.
	events
		ifEmpty: [ Transcript
				print: 'WARNING: No ';
				print: aggregateClass;
				print: ' found with ';
				print: (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]);
				cr.
			result := nil ]
		ifNotEmpty: [ :evts | 
			result := aggregateClass new.
			result applyEvents: evts ].
	^ result