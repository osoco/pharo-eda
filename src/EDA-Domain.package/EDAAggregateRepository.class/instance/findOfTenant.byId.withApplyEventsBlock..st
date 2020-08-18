api
findOfTenant: aTenant byId: anId withApplyEventsBlock: aBlock
	| result events |
	events := self findEventsOfTenant: aTenant byId: anId.
	events
		ifEmpty: [ self
				logWarningMessage:
					'No ' , self aggregateClass greaseString , ' found with '
						, (anId ifNil: [ 'null id' ] ifNotNil: [ :v | 'id ' , v ]) , '.'.
			result := nil ]
		ifNotEmpty: [ :evts |
			result := self aggregateClass new.
			aBlock value: result value: evts.
			result isDeleted
				ifTrue: [ result := nil ] ].
	^ result