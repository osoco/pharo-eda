lifecycle
subscribe
	self subscriptionId: self nextId.
	self subscribe: self subscriptionId usingClient: self client withConfig: self config.
	^ self subscriptionId