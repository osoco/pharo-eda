lifecycle
syncOnMessageDo: aBlock usingClient: aClient withConfig: config
	aClient
		runWith: [ :message |
			self logInit: message body asString usingClient: aClient withConfig: config.
			aBlock value: message body asString.
			config ack = #'client-individual'
				ifTrue: [ aClient writeWithReceipt: message ackFrame ].
			self logFinish: message body asString usingClient: aClient withConfig: config ]