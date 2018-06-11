lifecycle
unsubscribe: id usingClient: aClient
	| unsubscribeFrame |
	listenerProcess
		ifNotNil: [ listenerProcess terminate.
			unsubscribeFrame := StampUnsubscribeFrame new id: id.
			aClient isConnected
				ifFalse: [ aClient open ].
			[ aClient writeWithReceipt: unsubscribeFrame ]
				on: Error
					do: [ "ignore this error" ].
			aClient close ]