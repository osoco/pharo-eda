reset - events
resetEventProducer
	self eventProducer ifNotNil: [ :producer | producer close ].
	self eventProducer: nil