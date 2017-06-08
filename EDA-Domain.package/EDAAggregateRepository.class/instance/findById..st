api
findById: anId
	| result events criteria cls |
	cls := self aggregateClass.
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	events := self eventStore findEventsOfAggregate: cls whereCriteria: criteria.
	events
		ifEmpty: [ Transcript
				print: 'WARNING: No ';
				print: cls;
				print: ' found with ';
				print: (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]);
				cr.
			result := nil ]
		ifNotEmpty: [ :evts | 
			result := cls new.
			result applyEvents: evts ].
	^ result