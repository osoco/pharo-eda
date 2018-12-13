initialization
initialize
	super initialize.
	self unprojectedEvents: OrderedCollection new.
	self createdAt: DateAndTime now.
	self lastModified: self createdAt