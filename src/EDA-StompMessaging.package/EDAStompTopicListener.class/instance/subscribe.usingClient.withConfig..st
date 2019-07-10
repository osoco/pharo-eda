lifecycle
subscribe: id usingClient: aClient withConfig: aConfig
	| subscribeFrame ack |
	aClient open.
	subscribeFrame := StampSubscribeFrame new.
	subscribeFrame destination: aConfig destination.
	subscribeFrame persistent: aConfig durable.
	subscribeFrame id: id.
	subscribeFrame prefetchCount: aConfig prefetchCount.
	ack := aConfig ack.
	(ack = #auto) ifTrue: [ self logErrorMessage: 'ACK is auto. Resetting it to client-individual'. ack := #'client-individual'. ].
	subscribeFrame ack: ack.
	aClient writeWithReceipt: subscribeFrame	