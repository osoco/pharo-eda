reset - events
resetEventStore
	self eventStore ifNotNil: [ :store | store close ].
	self eventStore: nil