api
findById: anId withApplyEventsBlock: aBlock
	| result events |
	events := self findEventsById: anId.
	events
		ifEmpty: [ Transcript
				print: 'WARNING: No ';
				print: self aggregateClass;
				print: ' found with ';
				print: (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]);
				cr.
			result := nil ]
		ifNotEmpty: [ :evts | 
			result := self aggregateClass new.
			aBlock value: result value: evts ].
	^ result