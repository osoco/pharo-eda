code generation - repository
generateRepositoryFindByIdMethod
	| result cr aggregateClassName |
	cr := Character cr.
	result := WriteStream with: String new.
	aggregateClassName := self retrieveAggregateClassName.
	result
		nextPutAll: self generateRepositoryFindByIdMethodName;
		nextPutAll: ' anId';
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result events criteria |';
		nextPut: cr.
	result
		nextPutAll: '	criteria := Dictionary new.';
		nextPut: cr.
	result
		nextPutAll: '	criteria at: ''id'' put: anId.';
		nextPut: cr.
	result
		nextPutAll: '	events := self eventStore findEventsOfAggregate: ';
		nextPutAll: aggregateClassName;
		nextPutAll: ' whereCriteria: criteria.';
		nextPut: cr.
	result
		nextPutAll: '	events ifEmpty: [ Transcript print: ''WARNING: No ';
		nextPutAll: self aggregate;
		nextPutAll: ' found with '' , (anId ifNil: [ ''null id'' ] ifNotNil: [ :v | ''id '' , v ]); cr. result := nil ]';
		nextPut: cr.
	result
		nextPutAll: '		ifNotEmpty: [ :evts | ';
		nextPut: cr.
	result
		nextPutAll: '			result := ';
		nextPutAll: aggregateClassName;
		nextPutAll: ' new.';
		nextPut: cr.
	result
		nextPutAll: '			result applyEvents: evts. ].';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
		nextPut: cr.
	^ result contents