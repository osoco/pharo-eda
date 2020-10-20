aggregate selection
aggregateSelectionCriteria
	| result |
	result := Dictionary new.
	self aggregateRootId
		ifNotNil: [ :v | result at: 'id' put: v ].
	^ result