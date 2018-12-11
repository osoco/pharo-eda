API
publishMessages: messageCollection inTransaction: transactionId usingClient: aClient withConfig: config
	| beginFrame commitFrame |
	aClient isConnected
		ifFalse: [ aClient open ].
	[ 
	beginFrame := StampBeginFrame transaction: transactionId.
	aClient writeWithReceipt: beginFrame.
	messageCollection
		do: [ :message | 
			self
				publishMessage: message
				inTransaction: transactionId
				usingClient: aClient
				withConfig: config ].
	commitFrame := StampCommitFrame transaction: transactionId.
	aClient writeWithReceipt: commitFrame ]
		ensure: [ aClient close ]