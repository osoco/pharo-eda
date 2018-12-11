initialization
initializeWriter
	self writer: [ :event | self writeEvent: event ]