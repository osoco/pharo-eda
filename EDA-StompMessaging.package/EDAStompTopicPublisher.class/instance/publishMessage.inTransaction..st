API
publishMessage: aMessage inTransaction: transactionId
	^ self publishMessage: aMessage inTransaction: transactionId usingClient: self client withConfig: self class