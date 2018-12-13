initialization
initialize
	super initialize.
	self client: (self buildClientWith: self class)
