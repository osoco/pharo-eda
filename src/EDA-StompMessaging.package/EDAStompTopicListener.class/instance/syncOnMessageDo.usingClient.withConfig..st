enumerating
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	aClient
		runWith: [ :message | 
			self logInit: message body greaseString usingClient: aClient withConfig: conf.
			[ | text |
			text := message body greaseString.
			aBlock value: text.
			conf ack = #'client-individual'
				ifTrue: [ self logDebugMessage: 'Sending ACK...'.
					aClient writeWithReceipt: message ackFrame.
					self logDebugMessage: 'ACK sent.' ]
				ifFalse: [ self logDebugMessage: 'Skipping ACK (type is ''' , conf ack greaseString , ''').' ].
			self logFinish: message body greaseString usingClient: aClient withConfig: conf ]
				on: Error
				do: [ :ex | 
					((ex isKindOf: StampError) and: ex messageText = 'AMQP channel died')
						ifTrue: [ ex signal ].
					self logErrorMessage: '<< Error consuming message: ' , ex description greaseString, ' (' , thisContext stack last greaseString, ').'.
					conf ack = #'client-individual'
						ifTrue: [ | nack |
							self logDebugMessage: 'Sending NACK message... ' , message greaseString , '.'.
							nack := message nackFrame.
							nack headers at: 'requeue' put: 'False'.
							aClient writeWithReceipt: nack.
							self logDebugMessage: 'NACK message sent ', message greaseString , '.'] ] ]