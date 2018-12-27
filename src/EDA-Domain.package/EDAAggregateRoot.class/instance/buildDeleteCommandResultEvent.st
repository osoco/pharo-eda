helper
buildDeleteCommandResultEvent
	| result eventClass candidates |
	eventClass := nil.
	candidates := EDADeleteCommandResultEvent allSubclasses
		select: [ :cls | 
			cls aggregateRootClass = self class
				and: [ (cls greaseString indexOfSubCollection: 'Test' startingAt: 0) = 0 ] ].
	candidates
		ifEmpty: [ self logErrorMessage: 'Cannot find delete event for aggregate: ' , self class ]
		ifNotEmpty: [ :c | 
			c size > 1
				ifTrue: [ self logErrorMessage: 'Too many delete events for aggregate: ' , self class ].
			eventClass := c first ].
	result := eventClass ifNotNil: [ :cls | cls new ].
	^ result