api
findById: anId withApplyEventsBlock: aBlock
	| result events |
	events := self findEventsById: anId.
	events
		ifEmpty: [ self logWarningMessage: 'No ', self aggregateClass greaseString, ' found with ', (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]) , '.'.
			result := nil ]
		ifNotEmpty: [ :evts | 
			result := self aggregateClass new.
			aBlock value: result value: evts ].
	^ result