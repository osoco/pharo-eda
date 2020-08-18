api
findEventOfTenant: aTenant byId: anId type: aType andCommandId: aCommandId
	| criteria result |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	criteria at: '#instanceOf' put: aType greaseString.
	aCommandId ifNotNil: [ :cId | criteria at: 'commandId' put: cId ].
	result := self findAllEventsOfTenant: aTenant matching: criteria.
	^ result
		ifEmpty: [ nil ]
		ifNotEmpty: [ :r |
			r size > 1
				ifTrue: [ self
						logErrorMessage:
							'More than one event of type ' , aType greaseString , ', id '
								, anId greaseString , ' and command id: '
								, aCommandId greaseString , '.' ].
			r first ]