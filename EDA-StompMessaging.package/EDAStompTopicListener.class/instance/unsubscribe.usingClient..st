lifecycle
unsubscribe: id usingClient: aClient
	| unsubscribeFrame |
	listenerProcess
		ifNotNil: [
			listenerProcess terminate.
			unsubscribeFrame := StampUnsubscribeFrame new id: id.
			aClient isConnected
				ifFalse: [ aClient open ].
			[ aClient writeWithReceipt: unsubscribeFrame ]
				on: StampError
					do: [
						"ignore this error"
						 ];
				on: ConnectionTimedOut
					do: [
						"ignore this as well"
						 ].
			aClient close ]