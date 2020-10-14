API
publishMessage: aMessage
	^ self
		publishError: false message: aMessage
		usingClient: self client
		withConfig: self class