aggregate selection
aggregateSelectionCriteria
	| result |
	result := Dictionary new.
	self aggregateRootId ifNil: [ result at: 'id' put: nil ] ifNotNil: [ :v |  result at: 'id' put: v ].
	^ result