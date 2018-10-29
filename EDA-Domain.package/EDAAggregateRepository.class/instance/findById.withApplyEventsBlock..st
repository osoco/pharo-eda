api
findById: anId withApplyEventsBlock: aBlock
	| result events |
	events := self findEventsById: anId.
	events
		ifEmpty: [ self logWarning: 'No ', self aggregateClass, ' found with ', (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]) , '.'.
			result := nil ]
		ifNotEmpty: [ :evts | 
			result := self aggregateClass new.
			aBlock value: result value: evts ].
	^ result