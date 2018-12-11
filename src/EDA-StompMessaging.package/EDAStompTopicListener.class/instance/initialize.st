initialization
initialize
	self config: self class.
	self client: (self buildClientWith: self config)