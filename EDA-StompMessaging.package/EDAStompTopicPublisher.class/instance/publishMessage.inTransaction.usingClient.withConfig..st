API
publishMessage: aMessage inTransaction: transactionId usingClient: aClient withConfig: config
	| sendFrame |
	self logInit: aMessage usingClient: aClient withConfig: config.
	(sendFrame := StampSendFrame new)
		text: aMessage;
		destination: config destination;
		persistent: config durable;
		timeout: config timeout;
		transaction: transactionId.
	aClient writeWithReceipt: sendFrame.
	self logFinish: aMessage usingClient: aClient withConfig: config