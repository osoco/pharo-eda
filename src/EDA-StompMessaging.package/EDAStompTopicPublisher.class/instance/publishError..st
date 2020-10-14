API
publishError: aMessage
	^ self
		publishError: true
		message: aMessage
		usingClient: self client
		withConfig: self class