initialization
initialize
	super initialize.
	self delete: false.
	self timestamp ifNil: [ self timestamp: DateAndTime now asUTC ].
	aggregateRootClass := self aggregateRootClass greaseString