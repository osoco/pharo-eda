lifecycle
subscribe: id usingClient: aClient withConfig: config
	| subscribeFrame |
	aClient open.
	subscribeFrame := StampSubscribeFrame new.
	subscribeFrame destination: config destination.
	subscribeFrame persistent: config durable.
	subscribeFrame id: id.
	subscribeFrame prefetchCount: config prefetchCount.
	subscribeFrame ack: config ack.
	aClient writeWithReceipt: subscribeFrame